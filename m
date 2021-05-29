Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBFD6394B74
	for <lists+linux-btrfs@lfdr.de>; Sat, 29 May 2021 11:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbhE2JzU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sat, 29 May 2021 05:55:20 -0400
Received: from mail.am-soft.de ([83.218.36.120]:59192 "EHLO mail.am-soft.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229559AbhE2JzT (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 29 May 2021 05:55:19 -0400
Received: from mail.am-soft.de (localhost [127.0.0.1])
        by mail.am-soft.de (Postfix) with ESMTP id CC58E3B6EAE0;
        Sat, 29 May 2021 11:53:41 +0200 (CEST)
Envelope-To: linux-btrfs@vger.kernel.org
Received: from Bit02EX.bitstoregruppe.local (exchange01.bitstore.group [116.202.141.225])
        by mail.am-soft.de (Postfix) with ESMTPA id BA9213B6EADE
        for <linux-btrfs@vger.kernel.org>; Sat, 29 May 2021 11:53:41 +0200 (CEST)
Received: from tschoening-nb.fritz.box (77.78.163.99) by Bit02EX.bitstoregruppe.local (192.168.254.21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2;
         Sat, 29 May 2021 11:53:37 +0200
Date:   Sat, 29 May 2021 11:53:30 +0200
From:   =?utf-8?B?VGhvcnN0ZW4gU2Now7ZuaW5n?= <tschoening@am-soft.de>
Organization: AM-SoFT IT-Service - Bitstore Hameln GmbH i.G.
Message-ID: <1806742121.20210529115330@am-soft.de>
To:     <linux-btrfs@vger.kernel.org>
Subject: Re: How does BTRFS compression influence existing and new snapshots?
In-Reply-To: <20210528193612.GE11733@hungrycats.org>
References: <1743059466.20210528180204@am-soft.de> <20210528193612.GE11733@hungrycats.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [77.78.163.99]
X-ClientProxiedBy: Bit02EX.bitstoregruppe.local (192.168.254.21) To Bit02EX.bitstoregruppe.local (192.168.254.21)
X-C2ProcessedOrg: e1a4acb5-ea26-4a8f-9559-e23e579650e8
X-AV-Checked: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Guten Tag Zygo Blaxell,
am Freitag, 28. Mai 2021 um 21:36 schrieben Sie:

> Nothing happens to the snapshots.  'fi defrag' will make new, possibly
> compressed (but possibly not compressed) duplicate copies of the data
> in the listed files.  These copies will use separate storage space from
> the snapshots.

Thanks for clearing things up, that what's I expected already.

> Each individual extent written on the filesystem contains its own
> independent copy of compression parameters[...]

This brings me to the following in the wiki, not sure if it's worth an
additional thread:

> There is a simple decision logic: if the first portion of data being
> compressed is not smaller than the original, the compression of the
> file is disabled[...]

https://btrfs.wiki.kernel.org/index.php/Compression#What_happens_to_incompressible_files.3F

If (de)compression methods are managed by extents always anway, is the
statement in the wiki really true that compression of a whole FILE is
disabled if the first portion can't be compressed? Or does the quoted
sentence refer to EXTENTS instead of whole FILES instead?

"btrfs-compsize" prints the following for one of my directories, which
means that at least some parts of the file are compressed, others are
not.

> Processed 230 files, 754137 regular extents (754137 refs), 3 inline.
> Type       Perc     Disk Usage   Uncompressed Referenced
> TOTAL       87%      163G         187G         187G
> none       100%      130G         130G         130G
> lzo         57%       32G          56G          56G

So does this really mean that I was simply lucky because "the first
portion" of the file could be compressed? If that wouldn't the case,
the whole file would be uncompressed even though other parts of the
file might be compressed pretty well?

Referrring to the FILE in the wiki instead of EXTENTS doesn't make too
much sense to me currently.

Mit freundlichen Grüßen

Thorsten Schöning

-- 
AM-SoFT IT-Service - Bitstore Hameln GmbH i.G.
Mitglied der Bitstore Gruppe - Ihr Full-Service-Dienstleister für IT und TK

E-Mail: Thorsten.Schoening@AM-SoFT.de
Web:    http://www.AM-SoFT.de/

Tel:   05151-  9468- 0
Tel:   05151-  9468-55
Fax:   05151-  9468-88
Mobil:  0178-8 9468-04

AM-SoFT IT-Service - Bitstore Hameln GmbH i.G., Brandenburger Str. 7c, 31789 Hameln
AG Hannover HRB neu - Geschäftsführer: Janine Galonska


Für Rückfragen stehe ich Ihnen sehr gerne zur Verfügung.

Mit freundlichen Grüßen

Thorsten Schöning


Tel: 05151 9468 0
Fax: 05151 9468 88
Mobil: 
Webseite: https://www.am-soft.de 

AM-Soft IT-Service - Bitstore Hameln GmbH i.G. ist ein Mitglied der Bitstore Gruppe - Ihr Full-Service-Dienstleister für IT und TK

AM-Soft IT-Service - Bitstore Hameln GmbH i.G.
Brandenburger Str. 7c
31789 Hameln
Tel: 05151 9468 0

Bitstore IT-Consulting GmbH
Zentrale - Berlin Lichtenberg
Frankfurter Allee 285
10317 Berlin
Tel: 030 453 087 80

CBS IT-Service - Bitstore Kaulsdorf UG
Tel: 030 453 087 880 1

Büro Dallgow-Döberitz
Tel: 03322 507 020

Büro Kloster Lehnin
Tel: 033207 566 530

PCE IT-Service - Bitstore Darmstadt UG
Darmstadt
Tel: 06151 392 973 0

Büro Neuruppin
Tel: 033932 606 090

ACI EDV Systemhaus - Bitstore Dresden GmbH
Dresden
Tel: 0351 254 410

Das Systemhaus - Bitstore Magdeburg GmbH
Magdeburg
Tel: 0391 636 651 0

Allerdata.IT - Bitstore Wittenberg GmbH
Wittenberg
Tel: 03491 876 735 7

Büro Liebenwalde
Tel: 033054 810 00

HSA - das Büro - Bitstore Altenburg UG
Altenburg
Tel: 0344 784 390 97

Bitstore IT – Consulting GmbH
NL Piesteritz 
Piesteritz
Tel: 03491 644 868 6

Solltec IT-Services - Bitstore Braunschweig UG
Braunschweig
Tel: 0531 206 068 0

MF Computer Service - Bitstore Gütersloh GmbH
Gütersloh
Tel: 05245 920 809 3

Firmensitz: AM-Soft IT-Service - Bitstore Hameln GmbH i.G. , Brandenburger Str. 7c , 31789 Hameln
Geschäftsführer Janine Galonska






