Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD183958B4
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 May 2021 12:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbhEaKFj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Mon, 31 May 2021 06:05:39 -0400
Received: from mail.am-soft.de ([83.218.36.120]:44636 "EHLO mail.am-soft.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230521AbhEaKFi (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 May 2021 06:05:38 -0400
Received: from mail.am-soft.de (localhost [127.0.0.1])
        by mail.am-soft.de (Postfix) with ESMTP id 2AB3E3B80060;
        Mon, 31 May 2021 12:03:58 +0200 (CEST)
Envelope-To: linux-btrfs@vger.kernel.org
Received: from Bit02EX.bitstoregruppe.local (exchange01.bitstore.group [116.202.141.225])
        by mail.am-soft.de (Postfix) with ESMTPA id 1EC3B3B8005E
        for <linux-btrfs@vger.kernel.org>; Mon, 31 May 2021 12:03:58 +0200 (CEST)
Received: from tschoening-nb.fritz.box (77.78.163.99) by Bit02EX.bitstoregruppe.local (192.168.254.21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2;
         Mon, 31 May 2021 12:03:50 +0200
Date:   Mon, 31 May 2021 12:03:47 +0200
From:   =?utf-8?B?VGhvcnN0ZW4gU2Now7ZuaW5n?= <tschoening@am-soft.de>
Organization: AM-SoFT IT-Service - Bitstore Hameln GmbH i.G.
Message-ID: <192959599.20210531120347@am-soft.de>
To:     <linux-btrfs@vger.kernel.org>
Subject: Re: How does BTRFS compression influence existing and new snapshots?
In-Reply-To: <20210529221654.GG11733@hungrycats.org>
References: <1743059466.20210528180204@am-soft.de> <20210529221654.GG11733@hungrycats.org>
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
am Sonntag, 30. Mai 2021 um 00:16 schrieben Sie:

> If compression made an equal or larger extent, then btrfs will set the
> no-compress attribute for the inode.  Any future write to the file that
> reaches step 4 will not be compressed.

Thanks again, your answer might be a good enhancement for the wiki.

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






