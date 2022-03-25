Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDE7A4E718A
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Mar 2022 11:49:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346407AbiCYKvF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Mar 2022 06:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234522AbiCYKvD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Mar 2022 06:51:03 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B4F1DA41
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Mar 2022 03:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1648205364;
        bh=zqywDuqIO6tWWiLUjdbVyxm3zEOEa2E9RsPGXyR+dV0=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=LFa0vhr7rQiIlS+dmFJJ4mpMhRkwUYsjZGCTK8klHgK8PlTPnoTm89buujp4Mynx4
         bm9uz/1vtevPw0AVMUKD4NDgOFdUAF6SuNmjKGSpaxHpxOWSyxTZ8GYVPQ32QfUanh
         lCLB6AWt4m9oKVK3I2lG0SpeiI7wA/9aadyp2Tt0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N7R1J-1o7f1a1O6n-017nZ6; Fri, 25
 Mar 2022 11:49:24 +0100
Message-ID: <3cf47cbf-ae0d-2942-d427-7b6cb9602d27@gmx.com>
Date:   Fri, 25 Mar 2022 18:49:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] btrfs: replace a wrong memset() with memzero_page()
Content-Language: en-US
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <8d6f911a0282eba76f9e05d6f1e7c6f091d4870b.1648199349.git.wqu@suse.com>
 <PH0PR04MB7416A2B700E658F640B7FEF39B1A9@PH0PR04MB7416.namprd04.prod.outlook.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <PH0PR04MB7416A2B700E658F640B7FEF39B1A9@PH0PR04MB7416.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:y6ty7XlhH4Xzy3Id8gxf0xtVKq+w5CZhWwokCfNJU+VX9sQuWCJ
 VJx1qY6kNgje6Ftlcv5TJFyTKcZqJQlt5y32S8os/CB9sTOus38XiyQZmm3Ri6uyZzkZT2C
 3SPzUnHUv0WIsmYViJvTur9OhEXpcfcs+5cAC6O0MmcNYrudhfVN9xV2/QdQh1FgU7Z30in
 ebk7JSJPPRZzCE7IkpeOg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Pilolz5sAu8=:ildxdJCmgyT++f7FbOEzU/
 0BcHXmb2AJg2gAmmNYz59P2z1MC5iY7+J4YNB34OcuWKN62lxLW7Kbn8mK4QgLpno80kCvaNU
 6T7IFcdiCQuQpEuJMF92LaHxc5yW6nFUwnwrfneo1N6aLAvN4iWPgQjm1HL0ItxQncMUnBwGf
 m1OFi1U98vgDipThM+uIAx65IWenblMyBqqyhgoHs6P1WB7cgkzHzs8HmDvP3bqVxV7llFocz
 l+hNIZ6RFRuUOe0tV9hCPse9hk+EdhueDbrlHIJMO+PyF+OKF3n87/5mQOzWaR6INFgph2gx3
 pc8Ydbr88u6lO8opWNZveLhZJYQ2ff84sR9VIKiGT/b7uARFrHnQ6ME6iIXKsG7EcWuOYbyeG
 w1m/vid5H7DR90HUXkf/5iPWy+//SxrDiDgrLMn9pP7vgN9xh/5JczZr4zjLYuMBgOCPNoqV8
 7Wkr0NE++0TlhwqqYDjnbx0s2ZdDOLObB/Z5zX/DdoO+Xjy0NnYM1ozj+MQhoYwGDAPqKq+di
 wI6dGH6BT7eI9WdCb4qbvIR+w80pvo4zX8izwBdC8BBdnPfA0HfL/uS4NoFu3hNaFA4L1LAxA
 NLPk9p9FP53eL407l3o715sn6C1mADf14iOZlodBn3O9COgUZgiTdlW8r4JLYZO0QdljgIiMU
 SVxgUozkuBBgo8o3eo9mOca+INOR4JCGsdIMEGizqbAgp/M8BEij3EdW0e/L+QJLiLacP0br3
 F7O9afdJ2cuGTXz2pFi7bJX+2OycokT3V6O+HkBJ/tp3u7ss6PfCAMzceMExDmmKuhLxBSen4
 3YP5GVJfn86Dn4UxXDEuVviy/qrVb0CAqVyTmy8+phuOLaVI979AgqclsJtJMIn/6nLjJIkfE
 ZLEKQ8aKahTaIuXBbAkypKEyHN4ncm6m+fmn5TOH6df+PHKcq6repe+T8caf/0xo9xdTCHELi
 sr5UhpO+fWPpRT7vQ8l0vSJIMi9p516mL+ZSAuCsZQN7JYKoNGl8W3TZLfolyn+zdmcUWV9EZ
 z0C8NrNo7PjW8jeyw6XOtWohD/D9neFIF+NbYcb6qlG45pZL1otjkDQcu5FWMSucRTMjVI7LO
 Qr7zFUIgLVZFc8=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/3/25 18:10, Johannes Thumshirn wrote:
> On 25/03/2022 10:38, Qu Wenruo wrote:
>> The original code is not really setting the memory to 0x00 but 0x01.
>>
>> To prevent such problem from happening, use memzero_page() instead.
>>
>> Since we're here, also make @len const since it's just sectorsize.
>
> Any idea why we're setting it to 1? It's been this way since 07157aacb1e=
c
> ("Btrfs: Add file data csums back in via hooks in the extent map code")
> which landed in v2.6.29. So basically since the dawn of time.

No idea at all, maybe just a typo.

Thanks,
Qu
>
>
>
>
