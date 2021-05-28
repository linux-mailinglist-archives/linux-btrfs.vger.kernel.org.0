Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C719394788
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 May 2021 21:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbhE1Ths convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Fri, 28 May 2021 15:37:48 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:36452 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbhE1Ths (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 May 2021 15:37:48 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 9F9EDA7E956; Fri, 28 May 2021 15:36:12 -0400 (EDT)
Date:   Fri, 28 May 2021 15:36:12 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Thorsten =?iso-8859-1?Q?Sch=F6ning?= <tschoening@am-soft.de>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: How does BTRFS compression influence existing and new snapshots?
Message-ID: <20210528193612.GE11733@hungrycats.org>
References: <1743059466.20210528180204@am-soft.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <1743059466.20210528180204@am-soft.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, May 28, 2021 at 06:02:04PM +0200, Thorsten Schöning wrote:
> Hi everyone...
> 
> # Context
> 
> I have some Synology NAS storing backups created by WBADMIN from
> Windows using SMB, which means VHDX image files in the end with
> compression disabled, as otherwise WBADMIN refuses to work on those
> files. Those files need to still be available on the NAS for some
> time, but it's VERY unlikely that those need to be mounted again by
> anyone, therefore I would like to apply compression afterwards now to
> simply safe some space. If it's ever need to be mounted again, things
> can easily be decompressed, so let's ignore that for now. DSM provides
> all the necessary tools[1] to deal with compression of existing data
> on the shell as well:         
> 
> > chattr -R +c [...]
> > btrfs filesystem defragment -r -c [...]
> 
> The important thing to note is that the existing VHDX files are
> protected by automatically created snapshots already and the NAS
> continues to create snapshots automatically after I compressed the
> files. So what happens with those snapshots?

Nothing happens to the snapshots.  'fi defrag' will make new, possibly
compressed (but possibly not compressed) duplicate copies of the data
in the listed files.  These copies will use separate storage space from
the snapshots.

These commands are more or less equivalent:

	btrfs fi defrag -czstd foo

	touch foo.tmp; setfattr -n btrfs.compression -v zstd foo.tmp;
	cp -a foo foo.tmp; mv -f foo.tmp foo

There are some differences:  Defrag doesn't create a new inode, defrag
protects 'foo' against modification during the defrag process, and
defrag tries slightly harder to allocate contiguous space; however,
in either case, an entirely new copy of the file data is created
alongside the old data.  If the old data has no other references
(i.e. no snapshots) it is removed; otherwise, the old data remains.

> # Are blocks hold by existing snapshots compressed as well?

Compression affects only new writes--never any existing data already
on disk.

Each individual extent written on the filesystem contains its own
independent copy of compression parameters (well, _de_compression
parameters, strictly speaking).  It is possible for a single file
to use all 4 compression algorithms (none, zlib, lzo, and zstd) for
different extents.

> According this[2] explanation I don't think so. Additionally this
> would somewhat defeat the whole purpose of snapshots guaranteeing
> unchanged data for some point in time. Things simply were not
> compressed in the past when the snapshots were created, so in theory
> that data needs to be available somehow.
> 
> OTOH, compression is designed to be somewhat transparent anyway
> already and that might be argued all the way through to existing
> blocks even in snapshots. Might safe a lot of space in the end.
> Compression even is that transparent that "du"[3] is not able to
> recognize[4].
> 
> # Are newly compressed blocks changes hold by new snapshots?
> 
> I have a snapshot BEFORE compressing, compress the VHDX files and
> create a new snapshot AFTERWARDS. Nothing else changes in the VHDX by
> Windows or WBADMIN or whomever, so from a logical point of view the
> file is still unchanged. Though, the individual blocks/extents of the
> file managed by BTRFS have been changed a lot, depending on how good
> compression has been applied.

It doesn't matter whether the compression worked or not.  Defrag normally
makes a new copy of the data, and if there are other references to the
data then they are not disturbed.  In this case will be two complete
copies of the data:  one in the snapshot before, and one in the snapshot
after.

> This results in actual storage newly allocated between the two
> snapshots, doesn't it? So after compression, until earlier snapshots
> holding uncompressed data are deleted, overall storage might simply be
> less than before.

I think you meant overall free space will be less.  If so, then yes,
the compressed data and uncompressed data are separately stored duplicate
copies.

You could dedupe the snapshot using the new (compressed) snapshot as a
data source and the old (uncompressed) snapshot as dedupe destination.
You would have to create a custom tool for this, as none of the existing
dedupers are set up for this use case AFAIK.

> Or am I wrong somewhere? Thanks!
> 
> [1]: https://community.synology.com/enu/forum/1/post/138784
> [2]: https://superuser.com/a/892293/308859
> [3]: https://stackoverflow.com/a/20899536/2055163
> [4]: https://btrfs.wiki.kernel.org/index.php/Compression#Why_does_not_du_report_the_compressed_size.3F
> 
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
