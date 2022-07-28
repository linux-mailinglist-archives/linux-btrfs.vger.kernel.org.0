Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03A53584897
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Jul 2022 01:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233495AbiG1XN4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Jul 2022 19:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233481AbiG1XNz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Jul 2022 19:13:55 -0400
Received: from sonic317-33.consmr.mail.ne1.yahoo.com (sonic317-33.consmr.mail.ne1.yahoo.com [66.163.184.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028C360690
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Jul 2022 16:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1659050034; bh=Ofk1bxHeOF0JMWIDA4hTJzpOqTEXQY0BKl1APO/kYcQ=; h=To:From:Subject:Date:References:From:Subject:Reply-To; b=tHKV4NmkD37tPucZpB+YD/3v3rQXrw3CwZlGWiXt9HK4XWttWv0NKYXa7b+g2eo2sG9TDcRjXnPheEFovd5aaaA9F7g2InzLFfCqQ8E+/QaMLSA/mogy/7bxswhBDuKivIoqD27lMRJs4NUaaHW6x3eTVe8X72+gEr3aQvGedmr7pfC5SG/e6MmCdTGB1yvHXuZY3yjWRcLIX2L+vRm1ZIYa9i2EZR9/JkDeJ03F9/CMEttOQ7QMPPKnimqCeijCE3rzz61B1qTslTM8T+QoPZGpf7Ny8wu0QMkNfaiQlkQd7JVhRLWZ7bOKSlVZJdqwZCpZyQ2CjIz/fnjdki9xww==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1659050034; bh=dQgU2bgs7XrYl8bmi8LGVyr97oVuzvQzNFmcLVx74Gh=; h=X-Sonic-MF:To:From:Subject:Date:From:Subject; b=fV2pCZniHCvjfAxu9iXdXrMpNAno3PbvePWX33OPEobZIvvhZ9btfn6TtQT8sKXWZrPkBfliaIgTiFNHDYc2WkfhpFiXq3YUFY/Xxg+K2cWRFWs8XCmJXXI/VllH//5XZ3fns2uo8RvyIbbttb+eDG6+Y8gRdCbopl+G5B15WS9Nqe5Smsis+TLb6nW8996S/hGAHQvom6y0Jmc1+ii2u2+P7bDX/UZeA9dUcT1E/rBrM/1e0MafISGVaAJS/ao9t3o0bjAT1l/dJzGAWKDu1NKTW8OiEXBmmLrBaQWECTmABBQBQvwtxbE9n6FQukbgIItPZYoAQpLrfOv0AcqcGw==
X-YMail-OSG: 3JTIyNEVM1nqzmb.5kdjMVTx1t9zuVo6xoR895EFqc7GHgDuq.hGdPvrrDZHJDj
 pLTp7oqgUjIeiQYvv.Xgte0joRZo.Jri9RPVpCxeElEnX6YRu3ydTxOjvm2J55g_13PtpMn5YblU
 0KuWoj.ItWuz3cyBEQrcoQ77z8wLgS7_xp_EwG7WD5Yqf6MASGdMptSnX7tKoapMa_PuZ.y3rYvA
 x94APKhoCKgCzoEJqXrpAIrpTr3GS6VR2lFuDssnEaB8rGCbndNJRtLSgBrxS70aRBVagndB0i2h
 Sgjg5lm9m3Sw46skWuT5WkUF6WxbmDnEc9Tgfa6pTG5qfEsnkU0L5rz5NHGT1o4Yt6Ceove.Hdbl
 yBLl9tutdu_3pB8DkYZXlqZFRMrrr1_WC0fkv_FggXI_so8fSSyoYA7IQQR_z4qJXlOAVGldiwWl
 yAmjmnGtxr2bOuSESLqI_RK0NvkwKwZOmnU3Ygwia5.0263qztHX0cfMSPhflRvQ4leqYk2r.mZ8
 pfT0RtDCwmhK7ukwRAOjCXTOhz.Y38J1WoO0evnTZx.91C0yMLkB743mqjU_lOWP.V1vDHpTsnMM
 YhKrSIL6LQoifbS3ZG4BaYWuXphV3ibVRqUc2v5WwMExDqG1wdgowQyI6cOT7rJFXsg7Z3de8oU0
 VTq8Jw4J01KYtHWdOeN.AscMMs_bfuRhnf.ljsrrf1uZEUyk2Omwsl_b_S2BULgPfOI6wFji1Px4
 gj1uczGQDjIsu6tVHMdp6A1Qa.3zgsqtF3DGT3JtbDTYf1azdaLUXklHZ8F1mPizkOFXGD0p9wPo
 meinhCvcLdGAYvbqCEwQOoNsLsSRLoMhIMYtqC0eJ5PeH9wdWFfQsbhscYeLpL1SpfIAx1l_3OPX
 FUWjqMCAdLvpf3UT9uIBnjfy8cU3cMu4QhxKsUj_3X4KcjYBqCSVB1KVIz.9Kfr7ZI56h.rU0D9T
 Chjbj5vAGWC4Z6Xcilq0cur5dl6jVZ7g19Fxi2rklpDzOn4PCpwYZt3xn._GQeSHjPtyk9VDqQIm
 bT53pxqDJ_AMsyhmi8EIsgNzLOh5CISu.px5jkm_FRd.xWrMJyuneMqZ24LzLty1e0wsh8.qbOyk
 qQePnKguLZM7sNOkc0iKdhmJCfAwn1NkwW6HvrYGnUldL04C6B_GtRfPaL9RhU3henrOzm25JNaK
 .u2KRlspHLkW88DWm1LPbTXST1zUPwXBRRgdH_AsGXq9aT7yEtf1aVtScQ3D1QlpVwi29Kc1Fi6f
 aXC83tYJbz3pW7Y2r99a01d0AOd79SbIXRk9Z0Ruvj53tUF9oNRMZ4UEhuYCgUmU8QcVcJMnyHIj
 urUWGce84fL8ihgPGAgWrDt76iMewJzN5ozfEkI4Qz6IZ8GfLK3XxhQzq_gPrzNkmq4kyDBWBgW3
 oqaRPYth0fVSiMx4BWJMnlhVXEgdrfiL9XfTcyMHF_7cuDfq3v6Z6zZj6KBdTQ7NfoUedenPJhXj
 KOl8HhJ71O.RYvMW9nUjZRx6CsYDbZsrkm4D6_WGi4dkcxvaelTDGl8KAhNr0fDS_6Cl71sGVYva
 kmdeBXtYunK7mMPfDSywB3CLP_d99KfMflyO7E.QabD6zGiMKx.7sXP2IPBq6AIi5hydQ5LyluKY
 4TeVkpVYh_.UjV3z7uKjx9084vxREw8Q9E_RUXmJUmD_XH7wZhX7wDFPArGER_kG6y9CQW1BVRdy
 QC2OHtvp6WscW9GU1sxycBwyhpPMdR26RPzkA2i0gGfDM.zrkc8gVz7np_U5CRg.DFlHEa20zBsv
 gFTdvcL3gImJmS2DOwxjEx6ATmeIdyItn5rpwKpr.cTqCidcTG2ktyRhlxCRF1XNaTjBU4mg4sZq
 15yZjTo76lF4nUoLlWF_YJHIBcMPj9gRztasq185kg8QjLFTVJS2wG7iBK1_JzvZfJ4m3ZS_xQ3f
 x4jFkzlXAdtj9B3eflNApYtvlX.sYZ59olbwWlX8W3f2NA8BE_Zle1liyJCH3rMH0HqkaKx10rM6
 YxHr.EF4bg6qvPscsWRr8aKvAVPtBEI5uo29RaIU9wQ1OMY_TawiOlhVzSTAECQuxzkz_Ib8BuUM
 8aXM6vmvaF.DQC8OxytLlXq18cjWeDRcfXIfUnqcRwgZ_.QXG4chLCaMaNf.iuRuj0GgmUjTG_se
 LABI2t.JWNJTSgzbOjAJPeBhxiaz2U52PQAUfs8kKUZptnumj__eBetCmLUwOPCDA9ILPeRyqAv2
 yrVIS6oY1Z98_
X-Sonic-MF: <augusto7744@aol.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Thu, 28 Jul 2022 23:13:54 +0000
Received: by hermes--canary-production-ir2-d447c45b6-2r6st (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 2982feede48568fdb9becaaa6d6c00a4;
          Thu, 28 Jul 2022 23:13:52 +0000 (UTC)
To:     linux-btrfs@vger.kernel.org
From:   Augusto <augusto7744@aol.com>
Subject: how report kernel module bug ?
Message-ID: <d180c150-7216-b59c-fd84-f360be85279c@aol.com>
Date:   Thu, 28 Jul 2022 20:13:47 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Firefox/68.0 SeaMonkey/2.53.12
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
References: <d180c150-7216-b59c-fd84-f360be85279c.ref@aol.com>
X-Mailer: WebService/1.1.20447 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_05,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Thanks very much for read my message.
I want to report an problem in btrfs when using dm-writecache.
Please you has any information where I can to do bug report ?
Excuse if here not is the correct address.
Have an nice week.
