Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4CF8723434
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Jun 2023 02:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232989AbjFFA4v (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Jun 2023 20:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232685AbjFFA4u (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 5 Jun 2023 20:56:50 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B85EA
        for <linux-btrfs@vger.kernel.org>; Mon,  5 Jun 2023 17:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1686013007; x=1686617807; i=quwenruo.btrfs@gmx.com;
 bh=KBuW+Dek9A0Z4GT27FNjoZlqkerZS3bO/rDLxJMC8ns=;
 h=X-UI-Sender-Class:Date:To:From:Subject;
 b=cJRxAcS/PsMhdrbBrC+RlcyHbNX85ylGnt7gWOXXC8t8fFzjQM0YDFj9Bn4zwT7ZfvJsk2j
 h+EhOQr4hGwiRYGnPL2QxxZAXIN1D5+qcGtFQdLdZuy/va4s82w3eDdBuXu5du74XViqCysIU
 vYJBttDBU+V+rix2K5IAju2Zg2SrfckJnGVtgAQik3jNixz3Co3MD7CMYfnohXJeq9wbe4VMt
 6IQBJ3AZ8xfSyBZAJ993gdg+S3mZdrF67/iwwSNAtXRxV37CroSarlR1GlxYP/RMSLDyHh0+z
 2oRLsmfkVCz5q0AlPv73XMXXeqIcQJEqKVqkK5RRwKGRghK4YV+Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M3lcJ-1q649V0fkx-000rkn; Tue, 06
 Jun 2023 02:56:46 +0200
Message-ID: <2bb2dba6-b4d6-0298-a960-020d846878a2@gmx.com>
Date:   Tue, 6 Jun 2023 08:56:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Random RAID1C3 subpage read repair failure (btrfs/266)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vafdJ+Q742EeExExJzsb+TujX2czCmeLGzr5aPkeLBA16/Q18Hc
 asMBT2921bgrzj4jTyit+P2eDUUJavAFpTGnd4GLQ0EdLRzEH1HLcTCz/ouDuEN7Vc6ao/5
 MfnVggg2I0ue1Ws5adedu4/XRffVeaplq2tBR11WcPp/9GGL2LsO+KL1+p2PIwZEl+sdWEI
 fKQQqegqvYJ0h9hTWUeXQ==
UI-OutboundReport: notjunk:1;M01:P0:zAYChvIC0Xw=;Nix2ihx5kiJTan3f15yjt9Z/1Q1
 xEbFfchBFz+pRd4MfUU8NHOB6F87wrgPltBY5md/Sr/VUWVhniRYINFIM3TGXdySCK2Ay4JXP
 IAx8AuPcG4WBo7d3wAxN6xId0mfC+sdUI7Z8eOH9IWNmqGhg9uqWLY6uVUWe2EUm6WRyLNBZO
 in4R4hRwYgguEkVPzO0iGau7BQYKaT3amXtTyhSz1zn+Wlg2FIxTxEKbzH6O6zJ6i4r/Mo6MB
 klFt+lxYhhxoBFISQm3wCT/Aly1bjaPDaHmpZaU8Ux0CkTL7a+vlcbtAvRBn4joaY77DwzSvg
 Ek+IpC8jloCvgPtJAato1d8h8IaDukbN5pWNIcQVhcZOieBydB1JB5yDkYqkc95Me8HCcoDqm
 r2IBzS/MSIQhbSIgDhbf7z/KGYBXcpmfcLJslLHogv1LGSYGb7KJ+nVig+UFybj+b1/P4y+E+
 P+lNrl0B/vDP8lFw8U+HP5P5D6+d1mqajs2/dE2UndjZDebV/ZMu/mEOvLRHP4BtAb7sQ8n8i
 BqaSUhv6CE5J9u771Ao8BfDMuWh9+IpFRgLrFQCcyEPThFvDOTuZbaTEY4Zm8jOKTN6bcV46t
 p1tyT2h4ooADbky6TYji7P5XdXN3NKObo81ljZxfd7KtfQaq8lM7turCsos0Toth0nSQFhcJS
 3ckF1IRCCPve+PdSM9YUrXj64tMYh725Fez2LGMEhmH+Xrw+1qRptlxf5oeyGJ2txfsJ+81Rr
 nkja1cIXTpvrmi81TY7y2xQsS8SjD/Yrlyd4cY7ko4Jad0UjpjbvtlaQ6gB1NKGoAVgLG8itl
 F2NSEjmXp1tcDSgekicmiT7M+jbi7D6NYhNkNJJWpXCCJOQy0eaJMY9TA2Nujx/ZdbTbypoHV
 ud9JSXw7VtgCNsBvF5NSqyV8W3fcO6HwCeCnshsiwsfJmrR2ERxeNkT36vd8K76I6HssIEANa
 B5CRqVCPH6KAZOF6ThtWV41PPKY=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi guys,

With recently resumed subpage tests, I'm hitting random failure in
btrfs/266 with subpage tests only. (64K page size with 4K sector size)

The failure rate is around 1/3 ~ 1/5, a "./check -I 10 btrfs/266" run is
always ensured to trigger a failure.

The most common (if not the only) failure is that mirror 3 didn't get
repaired, while mirror 1/2 are properly repaired.

The dmesg doesn't provide enough info since it's rated limited.

What makes it more weird is, the test case itself is already considering
subpage/larger page size, thus except the final verification, everything
is done in 64K block size.

But still it failed to be reproduced on x86_64.


I'm still actively investigating the bug, but if anyone has some clue
it's would be very appreciated.

Thanks,
Qu
