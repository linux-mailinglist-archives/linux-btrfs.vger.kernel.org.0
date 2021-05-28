Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 446873945AB
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 May 2021 18:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232936AbhE1QMM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Fri, 28 May 2021 12:12:12 -0400
Received: from mail.am-soft.de ([83.218.36.120]:55642 "EHLO mail.am-soft.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230080AbhE1QMM (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 May 2021 12:12:12 -0400
X-Greylist: delayed 501 seconds by postgrey-1.27 at vger.kernel.org; Fri, 28 May 2021 12:12:11 EDT
Received: from mail.am-soft.de (localhost [127.0.0.1])
        by mail.am-soft.de (Postfix) with ESMTP id 3AD953B6B07C;
        Fri, 28 May 2021 18:02:14 +0200 (CEST)
Envelope-To: linux-btrfs@vger.kernel.org
Received: from Bit02EX.bitstoregruppe.local (exchange01.bitstore.group [116.202.141.225])
        by mail.am-soft.de (Postfix) with ESMTPA id 2EFD23B6B07A
        for <linux-btrfs@vger.kernel.org>; Fri, 28 May 2021 18:02:14 +0200 (CEST)
Received: from tschoening-nb.fritz.box (77.78.163.99) by Bit02EX.bitstoregruppe.local (192.168.254.21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2;
         Fri, 28 May 2021 18:02:11 +0200
Date:   Fri, 28 May 2021 18:02:04 +0200
From:   =?utf-8?B?VGhvcnN0ZW4gU2Now7ZuaW5n?= <tschoening@am-soft.de>
Organization: AM-SoFT IT-Service - Bitstore Hameln GmbH i.G.
Message-ID: <1743059466.20210528180204@am-soft.de>
To:     <linux-btrfs@vger.kernel.org>
Subject: How does BTRFS compression influence existing and new snapshots?
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

Hi everyone...

# Context

I have some Synology NAS storing backups created by WBADMIN from
Windows using SMB, which means VHDX image files in the end with
compression disabled, as otherwise WBADMIN refuses to work on those
files. Those files need to still be available on the NAS for some
time, but it's VERY unlikely that those need to be mounted again by
anyone, therefore I would like to apply compression afterwards now to
simply safe some space. If it's ever need to be mounted again, things
can easily be decompressed, so let's ignore that for now. DSM provides
all the necessary tools[1] to deal with compression of existing data
on the shell as well:         

> chattr -R +c [...]
> btrfs filesystem defragment -r -c [...]

The important thing to note is that the existing VHDX files are
protected by automatically created snapshots already and the NAS
continues to create snapshots automatically after I compressed the
files. So what happens with those snapshots?

# Are blocks hold by existing snapshots compressed as well?

According this[2] explanation I don't think so. Additionally this
would somewhat defeat the whole purpose of snapshots guaranteeing
unchanged data for some point in time. Things simply were not
compressed in the past when the snapshots were created, so in theory
that data needs to be available somehow.

OTOH, compression is designed to be somewhat transparent anyway
already and that might be argued all the way through to existing
blocks even in snapshots. Might safe a lot of space in the end.
Compression even is that transparent that "du"[3] is not able to
recognize[4].

# Are newly compressed blocks changes hold by new snapshots?

I have a snapshot BEFORE compressing, compress the VHDX files and
create a new snapshot AFTERWARDS. Nothing else changes in the VHDX by
Windows or WBADMIN or whomever, so from a logical point of view the
file is still unchanged. Though, the individual blocks/extents of the
file managed by BTRFS have been changed a lot, depending on how good
compression has been applied.

This results in actual storage newly allocated between the two
snapshots, doesn't it? So after compression, until earlier snapshots
holding uncompressed data are deleted, overall storage might simply be
less than before.

Or am I wrong somewhere? Thanks!

[1]: https://community.synology.com/enu/forum/1/post/138784
[2]: https://superuser.com/a/892293/308859
[3]: https://stackoverflow.com/a/20899536/2055163
[4]: https://btrfs.wiki.kernel.org/index.php/Compression#Why_does_not_du_report_the_compressed_size.3F

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






