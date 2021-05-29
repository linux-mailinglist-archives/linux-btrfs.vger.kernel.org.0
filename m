Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 551BF394E5D
	for <lists+linux-btrfs@lfdr.de>; Sun, 30 May 2021 00:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbhE2WSe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sat, 29 May 2021 18:18:34 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:39712 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbhE2WSe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 29 May 2021 18:18:34 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 2FFB0A80472; Sat, 29 May 2021 18:16:55 -0400 (EDT)
Date:   Sat, 29 May 2021 18:16:55 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Thorsten =?iso-8859-1?Q?Sch=F6ning?= <tschoening@am-soft.de>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: How does BTRFS compression influence existing and new snapshots?
Message-ID: <20210529221654.GG11733@hungrycats.org>
References: <1743059466.20210528180204@am-soft.de>
 <20210528193612.GE11733@hungrycats.org>
 <1806742121.20210529115330@am-soft.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <1806742121.20210529115330@am-soft.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, May 29, 2021 at 11:53:30AM +0200, Thorsten Schöning wrote:
> Guten Tag Zygo Blaxell,
> am Freitag, 28. Mai 2021 um 21:36 schrieben Sie:
> 
> > Nothing happens to the snapshots.  'fi defrag' will make new, possibly
> > compressed (but possibly not compressed) duplicate copies of the data
> > in the listed files.  These copies will use separate storage space from
> > the snapshots.
> 
> Thanks for clearing things up, that what's I expected already.
> 
> > Each individual extent written on the filesystem contains its own
> > independent copy of compression parameters[...]
> 
> This brings me to the following in the wiki, not sure if it's worth an
> additional thread:
> 
> > There is a simple decision logic: if the first portion of data being
> > compressed is not smaller than the original, the compression of the
> > file is disabled[...]
> 
> https://btrfs.wiki.kernel.org/index.php/Compression#What_happens_to_incompressible_files.3F
> 
> If (de)compression methods are managed by extents always anway, is the
> statement in the wiki really true that compression of a whole FILE is
> disabled if the first portion can't be compressed? Or does the quoted
> sentence refer to EXTENTS instead of whole FILES instead?

A bit of both.  Compression is controlled by file attributes, but the
result of compression is stored in extent attributes.

Here's the logic for handing a file write in current kernels:

	1.  If the file cannot be compressed, do not compress.
	This includes files with nodatacow or nodatasum attributes set.
	Also, compression is permanently disabled after fallocate is
	used on a file.

	2.  If the compress-force mount option is used, go to compress.

	3.  If defrag -c is running, go to compress.

	4.  If the no-compress attribute is set, do not compress.

	5.  If the compress mount option is used, or the file has
	the compress fsattr or btrfs.compression xattr set, run a
	heuristic algorithm to determine whether to compress.  If
	the heuristic algorithm does not recommend compression,
	then do not compress; otherwise, go to compress.

	6.  Otherwise, do not compress.

If we reach a "go to compress" case above, then btrfs attempts to compress
the data.  If the compressed result is smaller than the original (rounded
up to page size for non-inline extents), the compressed data is written
and we are done.

If compression made an equal or larger extent, then btrfs will set the
no-compress attribute for the inode.  Any future write to the file that
reaches step 4 will not be compressed.

defrag -c and compress-force always attempt to compress data if
compression is possible for the file, and never set the no-compress
attribute.

Note that the heuristic at step 5 means that compression is not
necessarily disabled on the first incompressible data to a file.  In most
cases, the heuristic algorithm will write those extents uncompressed
without attempting compression.  To disable compression, the data has
to get past the heuristic algorithm and then fail on the real compression.

Also note the heuristic at step 5 is not entirely accurate, so it will
reduce the overall compression ratio because of false positives (i.e.
it will sometimes reject compressible data).  compress-force will increase
the compression ratio by brute force, but as a side-effect (and possible
bug) it also limits the maximum extent size when compression fails, so
metadata size will increase.

> "btrfs-compsize" prints the following for one of my directories, which
> means that at least some parts of the file are compressed, others are
> not.
> 
> > Processed 230 files, 754137 regular extents (754137 refs), 3 inline.
> > Type       Perc     Disk Usage   Uncompressed Referenced
> > TOTAL       87%      163G         187G         187G
> > none       100%      130G         130G         130G
> > lzo         57%       32G          56G          56G
> 
> So does this really mean that I was simply lucky because "the first
> portion" of the file could be compressed? If that wouldn't the case,
> the whole file would be uncompressed even though other parts of the
> file might be compressed pretty well?

If you use the compress mount option, if you are doing many small writes
to a file, or the file contains a mix of compressed and uncompressed data,
you'll find compression eventually gets disabled, though not necessarily
on the first incompressible write.

If you are running a backup or similar server, you want the smallest size
possible, and you don't care about write latency, you probably want to
mount with compress-force, which overrides the nocompress attribute.

> Referrring to the FILE in the wiki instead of EXTENTS doesn't make too
> much sense to me currently.

Compression always takes place in the context of a file to set the
compression parameters.  Even the extents on disk need a file reference to
determine the compression type for reading.

> Mit freundlichen Grüßen
> 
> Thorsten Schöning
> 
> -- 
> AM-SoFT IT-Service - Bitstore Hameln GmbH i.G.
> Mitglied der Bitstore Gruppe - Ihr Full-Service-Dienstleister für IT und TK
> 
> E-Mail: Thorsten.Schoening@AM-SoFT.de
> Web:    http://www.AM-SoFT.de/
> 
> Tel:   05151-  9468- 0
> Tel:   05151-  9468-55
> Fax:   05151-  9468-88
> Mobil:  0178-8 9468-04
> 
> AM-SoFT IT-Service - Bitstore Hameln GmbH i.G., Brandenburger Str. 7c, 31789 Hameln
> AG Hannover HRB neu - Geschäftsführer: Janine Galonska
> 
> 
> Für Rückfragen stehe ich Ihnen sehr gerne zur Verfügung.
> 
> Mit freundlichen Grüßen
> 
> Thorsten Schöning
> 
> 
> Tel: 05151 9468 0
> Fax: 05151 9468 88
> Mobil: 
> Webseite: https://www.am-soft.de 
> 
> AM-Soft IT-Service - Bitstore Hameln GmbH i.G. ist ein Mitglied der Bitstore Gruppe - Ihr Full-Service-Dienstleister für IT und TK
> 
> AM-Soft IT-Service - Bitstore Hameln GmbH i.G.
> Brandenburger Str. 7c
> 31789 Hameln
> Tel: 05151 9468 0
> 
> Bitstore IT-Consulting GmbH
> Zentrale - Berlin Lichtenberg
> Frankfurter Allee 285
> 10317 Berlin
> Tel: 030 453 087 80
> 
> CBS IT-Service - Bitstore Kaulsdorf UG
> Tel: 030 453 087 880 1
> 
> Büro Dallgow-Döberitz
> Tel: 03322 507 020
> 
> Büro Kloster Lehnin
> Tel: 033207 566 530
> 
> PCE IT-Service - Bitstore Darmstadt UG
> Darmstadt
> Tel: 06151 392 973 0
> 
> Büro Neuruppin
> Tel: 033932 606 090
> 
> ACI EDV Systemhaus - Bitstore Dresden GmbH
> Dresden
> Tel: 0351 254 410
> 
> Das Systemhaus - Bitstore Magdeburg GmbH
> Magdeburg
> Tel: 0391 636 651 0
> 
> Allerdata.IT - Bitstore Wittenberg GmbH
> Wittenberg
> Tel: 03491 876 735 7
> 
> Büro Liebenwalde
> Tel: 033054 810 00
> 
> HSA - das Büro - Bitstore Altenburg UG
> Altenburg
> Tel: 0344 784 390 97
> 
> Bitstore IT – Consulting GmbH
> NL Piesteritz 
> Piesteritz
> Tel: 03491 644 868 6
> 
> Solltec IT-Services - Bitstore Braunschweig UG
> Braunschweig
> Tel: 0531 206 068 0
> 
> MF Computer Service - Bitstore Gütersloh GmbH
> Gütersloh
> Tel: 05245 920 809 3
> 
> Firmensitz: AM-Soft IT-Service - Bitstore Hameln GmbH i.G. , Brandenburger Str. 7c , 31789 Hameln
> Geschäftsführer Janine Galonska
> 
> 
> 
> 
> 
> 
