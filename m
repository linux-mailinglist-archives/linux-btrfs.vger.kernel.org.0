Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 211326BAA84
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Mar 2023 09:12:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbjCOIMX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Mar 2023 04:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjCOIMW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Mar 2023 04:12:22 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB81721A0A
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Mar 2023 01:12:20 -0700 (PDT)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M1HZo-1pf6KP37rm-002nfn; Wed, 15
 Mar 2023 09:12:12 +0100
Message-ID: <964f9378-c372-6c01-0ca0-3184022a54dc@gmx.com>
Date:   Wed, 15 Mar 2023 16:12:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 02/12] btrfs: introduce a new helper to submit bio for
 scrub
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1678777941.git.wqu@suse.com>
 <27af1ebdc7a7048895be3eaccd3fb437337e1830.1678777941.git.wqu@suse.com>
 <ZBF5r3itXwDKCsA8@infradead.org>
 <736958db-3c6e-7ae2-b1b6-c658cbbd0b96@suse.com>
 <ZBF8qeZ/Yp06baPF@infradead.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <ZBF8qeZ/Yp06baPF@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:YEcfe5xvF/VUycV02xP3KxF3/+A4VZEh0LhkSDtxauMi0M+JeSI
 XjwZfwP7grpWD/HJiRLqV7ay9OKpc08nRv/3SUfLOyTulRb75GdN/afx2TMBEVD0Wu2N02E
 ZynYF34DL/RMAZU/LWhGkTvySBYnEnQZmuOffkbj6HG3HB1BQRiazmRa2egu8TlB9lAkW0g
 JdoFMsM90F6fY/zvlT3CA==
UI-OutboundReport: notjunk:1;M01:P0:v/ukh8jDju8=;PrqPulOcnP3fa+wTk82ZTLNAxHU
 66BhDFR3XrBgcflNz7er1Q+MwkHGXETIH7PNSNb+i17WvxdcOXAzwscZTMe+s+hR2ko1vIGCy
 8EaF6YUwhy8YSi1luSCywVPpuEkZwt8Gv1j6RRDulRvVA1te6dfrXsWAk+E/fBk+hdXXvHgmy
 ed1NY1x9pmkNiBCmp9rmjuFTLZz0BbCVdv+KDTT9PMZuPsSOUAqDKV1p4tdE3JC2OmapcZeEi
 EHkH8uoCKa8/ABUwBOJMURGZDG3ZfISvtw9NUYFL8At4NIi6qi4lOFBdWcbjJ3zsokd9B2sLd
 VWamv/BYTyExkNWnhO2v/AyKYWnfFaGgk0cXpHXmH+H1BFFWvagPiuuM82B1Mo26Kx3aj0Tta
 WblAvng6EHMwSB9PBfZHtC/5RZdGvPYvATzEIW/30CSEbE7wbRrmsWMGhUFP3T2n/OLzsF0KZ
 0wrTiGq3pJY/9dgYWp1Vvm18VulDHqeGLiM7o+rDuGGTBX/V/NrzlJ9xbWyqQPSVPeC6u+IMy
 1KTaVkwiDMhRyxt31LjoTZ6E8HYXzwP57ZlzvKnPCLDy4cn0yOBA7c34xPbTSUOBxy38IMTy/
 nYtj14/IxU+HBCVP334FAopYHIOR2cCiUlbEl3c/D7nAAyqxRZsDFwNrEusYteYpRMgXBH1i/
 nj35UoBVHAi5ZBOki7VxjtTDNXS+BTO89+ybms22SrrGx2ttYQpmL0xvf6jDTTYwQ8vFGJCHu
 pgsOEVNNpoQylUmmv5dClMRgxU0MfYrn+LhRlUUa75rzzdLOoZlKreGd9ZyatIEoAmsaP/2dA
 1LuHjlkcdfpXKOCUIjqyUdn/hfJCbhqHfes7krxmfZb+nbC9lLNB2DDrp804wjLq+oAb0FMYS
 2sN/dndgPq67R2jc6ZdbLh1PzymV2JYzJTZmIcqk77PPP5kQjjfjK8+Denc9SWz+9f0o0XpG4
 h8d6oSE1iFmvp/Ljvr6sHVvTq9Q=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/3/15 16:07, Christoph Hellwig wrote:
> On Wed, Mar 15, 2023 at 04:04:19PM +0800, Qu Wenruo wrote:
>>> Ugg.  Let's not go into too crazy unions here that make the code
>>> alsmost impossible to use correctly.  If we want to get away without
>>> the inode we just need an extra unconditional fs_info field, which
>>> is what most users of ->inode actually use.  I can take care of that.
>>
>> If the memory usage is not a big deal, then I'm totally fine with a
>> dedicated fs_info member.
> 
> According to pahole we still have a fair amount of space in the
> btrfs_bio before increasing the allocation.  While I don't want to use
> it lightly, this seems like a good use case.

Sounds pretty reasonable.

So that's would be the way to go.

Thanks,
Qu

> 
> With a little more work I might be able to move the inode into a
> union leg only used for data writes as well.
