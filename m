Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFC17507D12
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Apr 2022 01:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243038AbiDSXLa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Apr 2022 19:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242419AbiDSXL3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Apr 2022 19:11:29 -0400
X-Greylist: delayed 392 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 19 Apr 2022 16:08:44 PDT
Received: from zimbra.karlsbakk.net (zimbra.karlsbakk.net [IPv6:2a0a:51c0:0:1f:4ca5::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6103C393D8
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Apr 2022 16:08:44 -0700 (PDT)
Received: from localhost (localhost.localdomain [IPv6:::1])
        by zimbra.karlsbakk.net (Postfix) with ESMTP id 6241F3C1DCA
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Apr 2022 01:02:07 +0200 (CEST)
Received: from zimbra.karlsbakk.net ([IPv6:::1])
        by localhost (zimbra.karlsbakk.net [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id M8ovdvXYstKk for <linux-btrfs@vger.kernel.org>;
        Wed, 20 Apr 2022 01:02:04 +0200 (CEST)
Received: from localhost (localhost.localdomain [IPv6:::1])
        by zimbra.karlsbakk.net (Postfix) with ESMTP id 4B1DF3C1FCC
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Apr 2022 01:02:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra.karlsbakk.net 4B1DF3C1FCC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=karlsbakk.net;
        s=1DC131FE-D37A-11E7-BD32-3AD4DFE620DF; t=1650409324;
        bh=Nje7ew82wljaoiRMOLFNfi2/BeblcNXbWUKN68gTVs8=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=Z/MwWZZ6O98F8UFoYyXoybJI/4rJlW9iY0Wfo3U90u+osVLqvRRKaftqjGUFgWP6F
         aRY1DclFo/2KVHQ9Jx/11BIiOd+wCKaoxHPKsBc1iqQMKFJdvQtAmf+hH8LIFh7pKr
         Txkg3KcGmhGapjM8WLBfG1rTKm4jshUTx022eQ3D8JqQ+TGkoyCJzgsauMUwOiUNvW
         rb8KOS2+3rqxYitIFDdCUPksnosAffbjAgsWGkVoY3/t7EubmGSw1LMOnInxMqprDd
         oBknwtWXg6kG/hOYkNwSoiHaX0ZSUomueEeth9NlXPy0lhnXT1q4XRyNFXdgdJlYfy
         hY1eO5ubQ4rYg==
X-Virus-Scanned: amavisd-new at zimbra.karlsbakk.net
Received: from zimbra.karlsbakk.net ([IPv6:::1])
        by localhost (zimbra.karlsbakk.net [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id EPgTmaiFyFaL for <linux-btrfs@vger.kernel.org>;
        Wed, 20 Apr 2022 01:02:03 +0200 (CEST)
Received: from zimbra.karlsbakk.net (localhost.localdomain [127.0.0.1])
        by zimbra.karlsbakk.net (Postfix) with ESMTP id AD9903C1DCA
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Apr 2022 01:02:03 +0200 (CEST)
Date:   Wed, 20 Apr 2022 01:02:02 +0200 (CEST)
From:   Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To:     linux-btrfs <linux-btrfs@vger.kernel.org>
Message-ID: <22677769.8507095.1650409322744.JavaMail.zimbra@karlsbakk.net>
Subject: RAID-[56] stabilisation
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [2001:700:700:403::6:1073]
X-Mailer: Zimbra 8.8.10_GA_3801 (ZimbraWebClient - FF99 (Mac)/8.8.10_GA_3786)
Thread-Index: AwF2artyHtDhuBO1B2Hr+83Sh8dbtQ==
Thread-Topic: RAID-[56] stabilisation
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi all

It's been a wee bit more than a decade since I started to look into btrfs a=
s a possible ZFS replacement. I just wonder when one can expect RAID-[56] t=
o stabilise as in usable for production, since this is, for my use, rather =
critial.

Vennlig hilsen / Best regards

roy
--
Roy Sigurd Karlsbakk
(+47) 98013356
http://blogg.karlsbakk.net/
GPG Public key: http://karlsbakk.net/roysigurdkarlsbakk.pubkey.txt
--
I all pedagogikk er det essensielt at pensum presenteres intelligibelt. Det=
 er et element=C3=A6rt imperativ for alle pedagoger =C3=A5 unng=C3=A5 ekses=
siv anvendelse av idiomer med xenotyp etymologi. I de fleste tilfeller eksi=
sterer adekvate og relevante synonymer p=C3=A5 norsk.
