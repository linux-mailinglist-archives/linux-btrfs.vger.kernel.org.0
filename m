Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31D8273A217
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jun 2023 15:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbjFVNns convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Thu, 22 Jun 2023 09:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbjFVNnr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Jun 2023 09:43:47 -0400
X-Greylist: delayed 546 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 22 Jun 2023 06:43:44 PDT
Received: from weasel.tulip.relay.mailchannels.net (weasel.tulip.relay.mailchannels.net [23.83.218.247])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C84118
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Jun 2023 06:43:44 -0700 (PDT)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 8D2E83E14BE
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Jun 2023 13:34:34 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
        (Authenticated sender: instrampxe0y3a)
        by relay.mailchannels.net (Postfix) with ESMTPA id 1A5CA3E1912
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Jun 2023 13:34:32 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1687440873; a=rsa-sha256;
        cv=none;
        b=ZRsLr/qKnO6AR+tEmCaxOdcVSDW3BoLNBr/vbBPMna3r9DcuRRmNDox2kC8F5RGsowSexF
        o9T/ftovpcTgcKEUR4589Io0m//gzzgnrGPq9eIO+cOapokuP4oYtaJNiA1Fl7Yfoea6A6
        //HbVSKbIN+Mo8HgSWRE2M/LFsJpj4Meu7qxBMFna+hLaNNIN6v/LhrspgvQ+bS+R2Y99H
        3GEKJg9PpA78MpBxqCQ7jhq6eWmxfnKwa8Ei7iXSfmbi7IDBxz0nManTsE299UmJUohs8w
        0oWS3ca8ZqfojZUh9lLghPg9Prx1yCbSKJJEDQCMZhddb/Zq44wgXdo16K5gYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1687440873;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=9cBSIdA6htPQoR1QbXPczQuWhR5s/8+2NqWBwyHrs2c=;
        b=10gVOF+6GHHVESdZDDOlDrfiuVl11rvs+iB354Itv+qS19tBwKX0d7bBbev2CHdfdn4xz8
        wXqqPH88ji6+J2d0JHYBf8pKro53ONnY5k/82S0diWtvSEP4S/s8S9rPpcqntz+3yEWfi0
        uUJmT3H0HlzCoNkiI5z4YDoXuOrK2PXhUvldb2+DCrIdCyTYc4/2LxIWzQqMqRIEwEv11+
        zNzmpUsE29EASSZzQnW8Oae4hkttOg/As82AzMRFoq9rJf+JeygOYNvCDmmUsGLygWDpk5
        4VPRoRaCYcIAJtN8+rZpCAivr0/yQyM3yNMSL3CKcA2EQUPu96r2KA7zSQ1wQw==
ARC-Authentication-Results: i=1;
        rspamd-85899d6fcc-d4zwr;
        auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Versed-Turn: 53fe0eef347cc707_1687440873924_1145049721
X-MC-Loop-Signature: 1687440873924:983991378
X-MC-Ingress-Time: 1687440873923
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.97.48.114 (trex/6.9.1);
        Thu, 22 Jun 2023 13:34:33 +0000
Received: from p5090fc90.dip0.t-ipconnect.de ([80.144.252.144]:32860 helo=heisenberg.fritz.box)
        by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <calestyo@scientia.org>)
        id 1qCKSD-00GJae-1e
        for linux-btrfs@vger.kernel.org;
        Thu, 22 Jun 2023 13:34:31 +0000
Message-ID: <ea6099a3cff73c20da032afaaeb446c0b12ec1da.camel@scientia.org>
Subject: empty directory from previous subvolume in a snapshot is not
 sent|received
From:   Christoph Anton Mitterer <calestyo@scientia.org>
To:     linux-btrfs@vger.kernel.org
Date:   Thu, 22 Jun 2023 15:34:26 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.3-1 
MIME-Version: 1.0
X-AuthUser: calestyo@scientia.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hey.

Not sure whether this is a bug or expected.

On my btrfs I have subvolumes like:
  data/
  2023-06-21/
where e.g. data/ contains the root filesystem and 2023-06-21/ is a ro-
snapshot thereof.


When I created 2023-06-21/ from data/, the latter contained another
(rw-)subvolume data/pictures/, which I've deleted (actually: moved out
the files back to data/ and rmdir-ed the now empty subvol... or maybe I
did btrfs subvolume delete - not sure anymore) again after creating the
snapshot.


Now 2023-06-21/ contains an empty (non-subvolume) 2023-06-21/pictures/,
which is expected.


Today I've send|received 2023-06-21/ to another btrfs (at that point,
the original data/pictures/ subvolume was already gone), and diff -qr -
-no-dereference-ed the two afterwards.

Outcome (apart from "differing" files/sockets/block/char special files)
is that the target doesn't contain the empty pictures/ dir.


Not a big problem for me,... but is this expected or some kind of
strange bug?


Thanks,
Chris.
