Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C05B96C45D
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Jul 2019 03:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732438AbfGRBj2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Jul 2019 21:39:28 -0400
Received: from sonic313-21.consmr.mail.gq1.yahoo.com ([98.137.65.84]:42839
        "EHLO sonic313-21.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727851AbfGRBj2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Jul 2019 21:39:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.ca; s=s2048; t=1563413965; bh=m6fsPxEaUTD8T/bMFq1wrgeVFPfouCKSZGQ9pR7/U4I=; h=Date:From:To:Subject:From:Subject; b=VThOsafllxBKTDXp5qd0pJ+EPO9ypWB3cPMWhlipn/4mh6anCvTd0F9ViMiV2mj3n9YzxSFqKBWVKXyOnHjY6zcT/JOOD7NdLDXA1OVjhAIsApwyjj+l0BycBiADuZucfVYXtEBH3znKlB45QUq4mTIeOrjlmRVYuf3akqM4VCXEMvpLE8PQsaWDqKrx39TlOlN83GNaUDVFd+gSYBdPizcICVPo+i/wg0ZAzo444hpq4i6Hh4sAIjzL/8Z2Hc8CsWZu03InLRWTxqxsveBgBg3uSc4EJSXvJO3eCRdh47B6M8JW2l2sdwDGJwRzm9kn9gI61FYQEJ9V/c29BgfDPw==
X-YMail-OSG: WKhc7PgVM1kpv8wwjqZOV_pmUoOOK53Hozp0VTHFJ0SaI6VmlaqZ7u7OBrqLLG0
 IGB.vbYcy9QtZ7PeeUsRMdrTBIvGiCWvlqpYSBeEEdmP86nT5X3kKGxsNpwes6YEFhotT.9Pu_3.
 EreVfKPwZGeTJFqBMlCuVzRUda4Y_qsUvZlY1JSTIO9DkjiDYJ5HQwzqJ_mJDbqxTrEg7b5rqmeW
 Fs2rks1fSRSfSV.7IfY_gxWLpDbKyn0N5KSMpIxLp0p__Sz9V5U_bTlnZT_INppiWNM8BG_q2eQn
 MZsuRR274SFakOhcPPIaAs2mN5e1kkdFubuB5Rb9XYTvFY96Grh_mV67LvaPA8uUU1YAGjEEVSCD
 ZT.b3Dx03kXrsJpjWUXHgLPRzX1RF5kiHiNeALFpMmh8ORKamPg7rfsuV8OZB4BA3EWxrV4W.aV2
 mKAuCJeiOuFILgsWbdyRhUcnUBgh1XgLwQiSF4Vyhf7Ik9NhWRnR1v1.uwBn_YYh9daBE_Or0n.4
 6IjIB_XcsAKV8xhEA73orqLFda09kpYQE.U_IJQog2OUWb1T4VkRW4JloFEqTirOeXeMWnTY_tpB
 uLCBoq3TAQKqllYoM1voJekppY91isRoJ09Rh87.3J5Sik6trZBTFP4AOuoqD0_9jiUqAySHgVVr
 JR4J71Hy8lACvxE4mw.OOKWhUYsFCGLbR1xMhiCPYlyEkEnMKeOnoc1MdhnSSbGEEjK0CDdlVEw5
 BD8DMSjOTs6o2eLMufQr_mCk7xFm.wuWH3AcXdmmu6ywUZ3eACG_c3AetIS9r3z6gdeA_sm0b8Ph
 _6rWKUTqDyAp2gcvdOvlY5AW_JbLxL3hnwmOmMGf7FImzII3PGd0TztpJehiCG12NDdSVOsAd4M2
 9VMLJkH3luv_CTtdA9kAM_kDqWPwnw2DYEuhiV1iIX7.Fy9aAMxfL0wHQM6SW1azFR87FcdQuLjc
 Uo4URlr0oi3E7plfj7tqOAfVjVqRQHGxS505LyPYqVFOBaTTk9GzbHu4QAnHSumJGuVaIZTRZ3Rj
 w4Ohu5SemEpS739kAbqX9RGXMqAs_iHyHb5DaqJmPvyzEkLXRnh2wbPZNIqJv3Az03TRxZmgA66G
 hqVMoHlkm_sVtlINkA_C_F4910TGZzpNFd9g1tQcycxRShj4I9PrknezScFY12wZwJ9zL1hDIvg8
 sqF2a..PAzZh4G5XR4ZsKhosqKr2HNBkdg2ZFVOdN
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.gq1.yahoo.com with HTTP; Thu, 18 Jul 2019 01:39:25 +0000
Received: by smtp419.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID c2a5ae82bcea9f5c6c5f86888515b23b;
          Thu, 18 Jul 2019 01:39:24 +0000 (UTC)
Received: from node1.localdomain (localhost [127.0.0.1])
        by node1.localdomain (8.15.2/8.15.2) with ESMTP id x6I1dNPB006739
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Jul 2019 21:39:23 -0400
Received: (from parkw@localhost)
        by node1.localdomain (8.15.2/8.15.2/Submit) id x6I1dLMe006738
        for linux-btrfs@vger.kernel.org; Wed, 17 Jul 2019 21:39:21 -0400
Date:   Wed, 17 Jul 2019 21:39:21 -0400
From:   William Park <opengeometry@yahoo.ca>
To:     linux-btrfs@vger.kernel.org
Subject: (btrfs-progs-v5.2) btrfs balance status /path  --> starts balance,
 instead of reporting status
Message-ID: <20190718013921.GA6695@node1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi, (I'm not subscribed).

In btrfs-progs-v5.2 (and -v5.1.1, don't know about older versions), when
there is already balancing operation, then
    btrfs balance status /path
reports its status. (OK)

But, there is no balancing operation, then it starts the balancing,
instead of reporting some "status". (BUG)
-- 
William Park <opengeometry@yahoo.ca>
