Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D86BB4E4D05
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Mar 2022 08:01:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242043AbiCWHDW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Mar 2022 03:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234794AbiCWHDW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Mar 2022 03:03:22 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E057B71EF2
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Mar 2022 00:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1648018906;
        bh=McBK0fu6lgmNZfaNMuZBmhc92nkgP+De7YoXuLlQq9s=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=eXNwAA9ZHaPwySXhbbWyRHT0/N4FEBZNKdzIOMcSNXkDgsp34u9HZz29k6vxTAknI
         xVm6zvYriNbwcKtBpIpS4ZsWEkCmzdhven2/LbW4FXXlNHZG6IFco/gxOWbjmLzO9G
         /6W1MJ36i3cT96ZltdS/SQbWk2swYZ+xe8N9btQ8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M8hZD-1nSoGG0Qdt-004lAN; Wed, 23
 Mar 2022 08:01:45 +0100
Message-ID: <3d5aaf86-ff17-0cde-7ef0-f805f8b25b25@gmx.com>
Date:   Wed, 23 Mar 2022 15:01:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v4 2/9] btrfs: introduce a helper to locate an extent item
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1646984153.git.wqu@suse.com>
 <140f3318f93d004713e12c10dc44f7640f04856e.1646984153.git.wqu@suse.com>
 <Yjq935OOywPFefuo@infradead.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <Yjq935OOywPFefuo@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WQgaQNseQEUFNbL4jeXtMowdy6MrX0Iz8EqUCQVSbSfxtfaKg+7
 1yAT6q010RzBxFVtgsvefBLy/qtahPZ6ZE/7pw8SOR8rO1aqDoZGiEdKYGwn0g9apTfE0ri
 7rKHO73UZBiGmEiv683OCvONZA4oJ6azrb4NfgHl0s+uirH20T5veZrjY3/jO21J1ZlBgUT
 JtcHst6oibqSeLJw645Dg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VRQbdYGaB3E=:NUAhUcr9vvE9Gx4B8bj++S
 fiCFZ80HzReNQ9vtcmL8jH84PdcNiRIUyt//UYOiqbOVKxkvaRJ9GxJ3F8h7LwgoUrNX3pLZy
 qdJL7Ak9qALYtBUxNPljYP2qrmUCkMkLKXZAaYbr/iICkMKZXxQ/1uzXmKcUi/5iqWL2aTBY1
 SlzDqEaqLCtvgNxJ8+NNUsyI0aC3a+vgQ/mtp2IBXakUu9Q+myOBJ8dECo7RF100MfCDGeOZd
 OhLrLmI0eXO2ReR/V4NoZ45GKwayUajPKuW43DzWa+fBOmOMpN1VOyL+XUBSVmcOB0Em//8Sn
 ZARr7j9ZGkgrFBFmqoCTn3OvJp9uesfpYIuriz57IJPoEF6L8VAFVzdeH65DTKBp3M4BPV1Ah
 XTSFQyUWqO12fpGK6UVNoL87evQ8kaM7+QVsdwD//X4CfeFJWtL9S90txRN3g9PdV8xQpWCkc
 +lrOkK+0nXNqi0u7zHeOczqBLWoMcC1vxAY16ArKDAYaL21vCAHgjAmiEGqzUTLXNtNylLgOh
 d0f5ucls1iJP/4AhdRZpMwFBjTRyLGbH/KMZhCyTnQmSLrO6uew6cE2F4PN0vHJIMCu0ad+3p
 wLQdkj21k/DLoIukq8bdWZ1jvkOxuSuIRTRGVbaXXcqSnocToI3TImfo6xiTGr/iMzjjdaauL
 YZnKE6L45aDf6aHgEyneGthfHc08JnO+zZ+O/x+yRWsqIuN3pltbPBFs+PhSiPm5THxk+2Qe5
 WG8rEnfQYJaUvYF8Mzn86q95xoVp0E/Ni9jbDnOCz1awtG9g74eaSS0n57lmyluTi8wEObwT+
 1Twxdcn4H542Ej1VYwnoDaANE0cRQ04c/epRETIldaMvBH+yRIo7bCSDr9CMwQ9E8UpLp/5Io
 XRMSZALvSCtEbvFGz7JvIxhurUrCCVOMTSeo6Q/3Evqhx4GFhvRzA2Q/nxOP5pc7Kqu5Y1H02
 81aXsZz6xY63BUhxv9yaqOZpLclyBM+Ek6IF9nwiYQ2cVnmy10CWaA6lzNTPxyXKq0I4w6lhw
 gL6W1GhLsJLi2ZSCqrp1knuQN09tEkhUM4/Kpw8JZlfbeQ1bvNqmrBmbKTdEq/sqeWIyQUDnq
 Ojig72ixXmQ0Wo=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/3/23 14:27, Christoph Hellwig wrote:
> Adding a static function without a user will generate a compiler
> warning.
Yep I know.

But considering the size of the helper, and the size of the next patch,
I'd say the split is acceptable, or there would be a near 400 lines
single patch for it.

Thanks,
Qu
