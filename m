Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCE1C58D0A8
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Aug 2022 01:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244537AbiHHXyq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Aug 2022 19:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiHHXyh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 Aug 2022 19:54:37 -0400
Received: from sonic302-22.consmr.mail.ne1.yahoo.com (sonic302-22.consmr.mail.ne1.yahoo.com [66.163.186.148])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A51BB1C11C
        for <linux-btrfs@vger.kernel.org>; Mon,  8 Aug 2022 16:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1660002876; bh=h+yfBUcO1s8IYxZA3hzYkksxCjCBxLWwp/CF0DGAyTY=; h=To:From:Subject:Date:References:From:Subject:Reply-To; b=XXIpnRJSkucMcam73I5awKMOGl3uHzlRUhNE3xA0i7N9OF7oFoV35iiY1mKnMRud7sRDBziyzyG3STFUl+5fgsHhbWBP8WmGgQckCoMpQn/ZcWmYuv/bEjCWsxB1Z5sZ3uB7/tuQaVvF+rnPdrc52VtznRURDQjC9ZQFmz+HEAg6H6WlYkKo8qxE+FvBaSOPsNNCZCE7UVIdA3dRS8vrD5ECI66r10totNbGXfeQ7XVaJcRz+McEa9T8mBPqQ3OPwzDouRhbdPM+WdQHxt9qwnz07pzCZBMyMc5ImzX7x3TOE4zdNIelPcNx6NhYxvyB4LbDiYtumJ5b36b9VmGyVw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1660002876; bh=Ju7DEeXmk66SYGN9uF+LivNlPUdv3sfjEP9Jwv3jccL=; h=X-Sonic-MF:To:From:Subject:Date:From:Subject; b=QEiCwfxaJYWXtrDrCXxKP3mNmhAw7Nq5HUZVXhuJ3bULEvwYoPIakeAI/qVRmiTvN1PER5Ghff7on8KSw/NkDehm2G6JaotqVuqbGGU8XfdMkpnjW64awuk2AKL9kjl4Kf3qloDOrLjQfqxskJIl4D2VFr8SL9T9YTa+JIuwkTAWdYggf+KShObuxfbs4Yvn7c6YggOuOJMYLqgWq1jqsKJbgV9YjRsvihYEKlHhVE7mR1tvHk4KaueB7kSlsucZ/WJ5MgjmSeFulZXWtLmnqpR9kBHNVvc6BdbMKUXqILyFzUpUXslVXC3ISido4OaZMErSqUH5W4zbyIdINu0+7A==
X-YMail-OSG: DUmXwNkVM1ncWkdKJ1uJtdEMmYwp5Z4ImZEB1gGy_Zh0JPRNNf.GO06ObdVUGy2
 y4DGFjEPT6mgYDwb9GD.remgbsm0D9q9bOZgakOyZgeahr3h6H9Er.gGtsYrM9bst4VKogIkMx.1
 jppuzLwMsl.GjswfMRkXgTXEYEQUf28Pod6j2OQbA7FJDihU5B1axU2Smu0o.YOglspaTd4vyO__
 B_1spx5CaHHw3KiNnoBr5Lv1r7uLxNTaWLea_FuEcOi4p8pePC09aR5iTo.1eI6pHKdsEk78frTj
 5rJ1ggxGVsmD9.uINseNHIi8srJqLMs76_K7udeJ44t.JirpWUGGgz.eB0AbB95QsiDt8KLzgDsi
 a0ycWbm61LOyTnjq_syzM5O.SFMkt8RsI58qjF5uP_OiIYm0U6UViXNabM.FpoDBoq64mFej8Y2e
 5Z_kW0PRwcAbclNs6OXdTV0NtfmqiTuZrriy7DQIVmV.XZCLbQdGrnAX9UlbC9Q8xGmJGc3isH_u
 WNPhbXi4W9ZdqI_ovKMR9HyfhXFNdfuf1Tj99T7_wiqg1mHUN7tDgSXMjAhcxaLbRt2fJHvoGNaw
 rwUnk5oukexR5WXDQQL1pLo4nI3gwDCArUAr295ofKYL_n9UBADjjEcNTCgezmFiTmea.RXLKFio
 TgiLEGDKxQOrIU3_vfbbMmsc4iGkXmX9JmfPt_AEQjxcrr1DLBT_JwJu7tFijp8bbo5xZpkg5q4U
 VlrB3yOBX.XeBQcwW0T4QAFNjPlmbuZr8Y7yXaJ9tapUyMnWZp_wboQwosFZBFamF.Vv5GuNglSK
 _bkHtpLco0CQw0b6rz5jC0RzXpnGOtXHRo16DYnzwKgvweB_ou5z0EQjlkurJLOZjFII4ZcNii1c
 Gft6mq_AweVdY7Wcqtue.rfWiQfb4tNd8VOzAk2.wFXWTdE9ZLEtTgrAO_pF7qPPzP0fgah885Im
 5faZwf0fRocJoyirSYi2SBOQ6N37Ie6d4fwjJIzqpJYe2R9v0JJ5roua0WR1AUOufdOZYhb6v5Lx
 8aqMKoiL3pq4BC.VdWzJ3R6ysUA7p7b_eWdyCklCduyTAKawp8IrX1PlkWkcuAto_mhm6ZOqG7IB
 S8sEwmjYIw2nkjCNKAJZZaKt79CHerr2.CjR0obVNP8qP6v7pIgfxyokdNHzTm6dW07r6Nmgq0gL
 9nLvHFEL.osgHWNrLyMs7MSM1TcFH1Anp13YP7eDGO1PQ.ncWAYkE4XKuNzFYdrtQE1LJvKgDeBc
 Y1Uedjt72INSYVhF9QJGwPDkd.uuR7eV3RC8YmPkDRCtkDMJwilyY9P7ENCj5d2s1ni6AdlpFwLO
 TtI6rPjyHNNPSiyWkCyaQ8yWV4Hk2CIUikAu8k7kVaPzeUVceuBt_GLOzgz9h_QaD6rEro63BBwH
 8cEo94V_fLNaF5HlCHdxJcNqPaalpyR_J1CElPsT4uui15xPP8cKGG2LoYO2jqqR6sVOT7b1Q91F
 rqzKxf3_19Ein5vR6hDEegikqlk_aMDVigOpjU2RBTN_hfpzsrxDLz8EbmXS4CJbwmo3GjPePxEb
 p0S025EQmpHEQh5Nacn7T6olShLzchlZnpoJCk70LKtuAYyGZN1j4FDluZbkGsprCACR9KQJp.EE
 S_qSWVQr.o4tW.wD72id5tcmCSb9dkpylsbwZYS6uF5fYtoqhumLgciojDgWNP49235ffAbMggll
 myT0u5ZA.s0DkGPfOPui.arXPy.8P1bnI8BnywM0W1_8IvtgLT5B5.mi4llLEWdyeD7.CwTCV3mx
 ivQDp8lCww0UKXeokeJADoEYqXlqO2XV2xsW6zvUvp_q041XkBDnNdValfq5JMVS2IJ1X2m3UI_b
 c5MxWfS4.hLNse94XQrqklJm95i2kT2kGYNxlMCHAeAxHizFZEEbilt1HizRKKPjk7M7Hi4XXvCE
 J2oGxC8AyRJD5XZswEctAkMgPPvAkOJ35wufmW5hKiJRYQx6A.AS1J5qxdUJOv63vk9WKo9coxWt
 6hsRZd.zFDy2y86.haiHDyiAfmszIMursUABb2HtUi1Hq979CyqgMjHiLkts5ywQ7zv30VrwLRad
 9VmDhQHzY..U1D2dp_MfhGkLZs5x8gZO01URdYCfPywElKEWYf2EGUC.zZpZ2eYN03lJDvdcQWVy
 s1RvGmLvpVmKXaHvwu9mwnHiH4OMip5uzp.N3XVCrmZrjwRdEZFEafM4ZaQLjYIu8jB_A6XCFAKJ
 iyfm1yfuZSGJPR6ShMGKF7ontOpKC
X-Sonic-MF: <augusto7744@aol.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Mon, 8 Aug 2022 23:54:36 +0000
Received: by hermes--canary-production-ir2-f74ffc99c-r76pr (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID df3c7f124e81172bcc3995538f2ffbe4;
          Mon, 08 Aug 2022 23:54:30 +0000 (UTC)
To:     naohiro.aota@wdc.com, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
From:   Augusto <augusto7744@aol.com>
Subject: btrfs bug
Message-ID: <016b3ac0-1524-6bfe-4261-c6adff00eb80@aol.com>
Date:   Mon, 8 Aug 2022 20:54:12 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:55.0) Gecko/202208101
 Firefox/103.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
References: <016b3ac0-1524-6bfe-4261-c6adff00eb80.ref@aol.com>
X-Mailer: WebService/1.1.20491 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello.
Thanks for read that message.
I see an bug when using dm-writecache in BTRFS.
I not see where to post about bug it.
I not wait support. Only report the bug.

If correct way to report bug not is with you ... please excuse me.
Have an nice week.
