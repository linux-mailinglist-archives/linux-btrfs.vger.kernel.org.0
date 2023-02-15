Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 081136976E2
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Feb 2023 08:01:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233502AbjBOHB5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Feb 2023 02:01:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233361AbjBOHB0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Feb 2023 02:01:26 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE19DBFF
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Feb 2023 23:01:24 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MI5QF-1pNZCs2phH-00FApu; Wed, 15
 Feb 2023 08:01:10 +0100
Message-ID: <6ae86850-7819-543e-2fbe-0f7f0376ae4b@gmx.com>
Date:   Wed, 15 Feb 2023 15:01:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH RFC] btrfs: do not use the replace target device as an
 extra mirror
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        Stefan Behrens <sbehrens@giantdisaster.de>
References: <2902738be4657ec16e5b5dd38eac1fb53aa5cc44.1675918006.git.wqu@suse.com>
 <Y+sy5xHfz6S16/oc@infradead.org>
 <e7a2cb06-d6b1-f40b-477a-dca130a4a5d2@gmx.com>
 <Y+x+GjgREMyYe5pP@infradead.org>
 <d2f73a10-7ec8-0b42-1a4e-eb86b0740741@gmx.com>
 <Y+yCncfD0EyfsxTe@infradead.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <Y+yCncfD0EyfsxTe@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:TCqjFDYSDT8KE8jEIFZsbiSE24Mhbe+z6x1DmTgW4gxK6hrpPfJ
 Ugawkv6BTvs8BWiIWgH/Ch/gqgLAKyBs/mFy0fUsaXY7JNpXeZCvmoJBIfj3YeBNpeXNm+j
 jefNRBFl3ZisS42lk7b1eF95lPlp/uxFYOOH+RDD2UjeVsSj/PwheyyJI1I7KDHq5aZZ2FH
 IsXNV5zMZ+qYBoxAdr3uw==
UI-OutboundReport: notjunk:1;M01:P0:J2kgZwWmvJE=;n4Otial14QKKmkfJIEvS1kH0eIW
 r4C0VocgHcVLGyp5T6q284qoWnavVCo3PTFnCQloOZr3irOv68R6hOho8BnNhP7xplyga3WT+
 W8Riiayt9CC+n/Y7BqckD+z7bfuMqDS+OerQ4Fx/d4g8CicwsFq7Goe9rUXRnbA5E9kb0MsM+
 kTXcs+gJ1lWFWwilJMk5qo7aRX20PqwyEXQeM+27ny4IBd5luFYfauy/XzFWqY1T6XfcIhL1F
 3yvKpSiUzTUDUxzGjY3s1OrAPQo1xT1m5xuGRZuiZnplbyQinLPk3tDbpqRUpPHhBNQOyWgjO
 DBVyMt/2WuVTZCJDdeAgp1sGXu9SR9TZYsgGamSwEI6SV6DxJQUN1k0KacIiKwPqFIUQZG5wQ
 K2G6x2fTEAEqVjUKPe2WC+jGh09yu3oinIzgtKOMDkYu6tWvdUMylHKlymw2luX4c2LmS5kDk
 NoItp9s0rptBuqFXq8bMb6wg4jNMBo+/N0jdFE1JXpSvkuQ8l/jC4vUqLOjzdrdJkvbLTBie7
 ON+lM/wd/51JMaHtI8G9+TvloOAwi6jIDqdgKhXVgBpn308HVSEnu2pyoOGVowwtXBszyyMa+
 uwmDfje++OZGZIJiJmmt+sYqnAjFKGN6YA0bGpc3yQHW+VMLOts9t/Z9ESty7P5ZY/PHtL49w
 DOcmO4JC6hW5rfKKxC4wdzBJFg2LUoPxqChlqnYGe7O6FOx5h5d1slIYhZZOJfsqZAIaRNxMb
 xeuq6fTziBURVy6dx8PD2zEHCH8RamxK6EVRrRyArMnRyswEQWd/lwkfUlK8n0YtQuC71i/Jn
 nSWMLU3Yipqc2nLUQ/OLa0k62GWkZPWlwphOXLPXsFsomFdIhOgCpbwz7DsJV9JRjCd8+p10u
 033cRsdx+Vy98aJnVBGkLJSisBu2yX7Og2FGYCR7cHt580lKaI1h1moj2S1TAxMyNgk26Qr3X
 vcxHVf+DsEj01nv5ydf90FtFeuI=
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/2/15 14:58, Christoph Hellwig wrote:
> On Wed, Feb 15, 2023 at 02:56:39PM +0800, Qu Wenruo wrote:
>> Meanwhile replace hasn't yet reached that bytenr, thus we're reading garbage
>> from target device.
>> And since NODATASUM, we trust the garbage, thus corrupting the data.
> 
> Yes, for a read from the target device to be useful, the progress
> needs to be tracked, and the read only needs to happen on data
> that actually was written.

I can still see some comments on this, but can not find the exact 
commits removing the replace progress check...

And if we go that path without a progress check, then the only valid way 
is to distrust the target device completely.

Thanks,
Qu
