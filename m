Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21CF67E1725
	for <lists+linux-btrfs@lfdr.de>; Sun,  5 Nov 2023 23:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjKEWAP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 5 Nov 2023 17:00:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbjKEWAM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 5 Nov 2023 17:00:12 -0500
X-Greylist: delayed 5206 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 05 Nov 2023 14:00:09 PST
Received: from SMTP-HCRC-200.brggroup.vn (unknown [42.112.212.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47265CC;
        Sun,  5 Nov 2023 14:00:09 -0800 (PST)
Received: from SMTP-HCRC-200.brggroup.vn (localhost [127.0.0.1])
        by SMTP-HCRC-200.brggroup.vn (SMTP-CTTV) with ESMTP id 353F2191B1;
        Mon,  6 Nov 2023 01:57:43 +0700 (+07)
Received: from zimbra.hcrc.vn (unknown [192.168.200.66])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by SMTP-HCRC-200.brggroup.vn (SMTP-CTTV) with ESMTPS id 2E86C18FE9;
        Mon,  6 Nov 2023 01:57:43 +0700 (+07)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.hcrc.vn (Postfix) with ESMTP id C0FC41B8204A;
        Mon,  6 Nov 2023 01:57:44 +0700 (+07)
Received: from zimbra.hcrc.vn ([127.0.0.1])
        by localhost (zimbra.hcrc.vn [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id HXeOkkoOtXGA; Mon,  6 Nov 2023 01:57:44 +0700 (+07)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.hcrc.vn (Postfix) with ESMTP id 9243C1B8250F;
        Mon,  6 Nov 2023 01:57:44 +0700 (+07)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra.hcrc.vn 9243C1B8250F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hcrc.vn;
        s=64D43D38-C7D6-11ED-8EFE-0027945F1BFA; t=1699210664;
        bh=WOZURJ77pkiMUL2pPLC14ifVPRvyTQIBEQmxuN1ezAA=;
        h=MIME-Version:To:From:Date:Message-Id;
        b=V9mjfwKUtdjR/jzW3G5p+y9g7SfCCZDedHAHYeULWSd/YVmozbltabuxy6pDIoSz+
         Xu1qlDmupV05CnxCgAldowCTtuc3ZCQyCy/Zi2q0PZ8yEQqgDG07N0b0IA9UJB2PS0
         mTlR2SW97CCiJcJCq2jgNlO1kMOO/Caa9J3n70spwbTXCwz/MuLoH348RVZB4umxLE
         lXopzof8ZGh4HkZwJv5tO7Ry9KSYuD794cXRNAPbEFU/VH00AbVmmhJ/+NB1Z2oaag
         PmEvYDNNc3sYLe2E7JbPISAs/CwPCQYIy8FXbC+7Qq7JrnUcREVB9z43eLhcydONc0
         OceqeDScJVIZw==
X-Virus-Scanned: amavisd-new at hcrc.vn
Received: from zimbra.hcrc.vn ([127.0.0.1])
        by localhost (zimbra.hcrc.vn [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Eck96ab-IFEO; Mon,  6 Nov 2023 01:57:44 +0700 (+07)
Received: from [192.168.1.152] (unknown [51.179.100.52])
        by zimbra.hcrc.vn (Postfix) with ESMTPSA id 3EA3B1B8204A;
        Mon,  6 Nov 2023 01:57:37 +0700 (+07)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: =?utf-8?b?4oKsIDEwMC4wMDAuMDAwPw==?=
To:     Recipients <ch.31hamnghi@hcrc.vn>
From:   ch.31hamnghi@hcrc.vn
Date:   Sun, 05 Nov 2023 19:57:27 +0100
Reply-To: joliushk@gmail.com
Message-Id: <20231105185738.3EA3B1B8204A@zimbra.hcrc.vn>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Goededag,
Ik ben mevrouw Joanna Liu en een medewerker van Citi Bank Hong Kong.
Kan ik =E2=82=AC 100.000.000 aan u overmaken? Kan ik je vertrouwen


Ik wacht op jullie reacties
Met vriendelijke groeten
mevrouw Joanna Liu

