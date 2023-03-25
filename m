Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB13B6C8CC8
	for <lists+linux-btrfs@lfdr.de>; Sat, 25 Mar 2023 09:48:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbjCYIsz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 25 Mar 2023 04:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbjCYIsx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 25 Mar 2023 04:48:53 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0260AF31
        for <linux-btrfs@vger.kernel.org>; Sat, 25 Mar 2023 01:48:52 -0700 (PDT)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M2f5T-1pcQGy0N2t-0049HP; Sat, 25
 Mar 2023 09:48:43 +0100
Message-ID: <1698cfcc-8beb-7211-2e4f-2e8e5e363ece@gmx.com>
Date:   Sat, 25 Mar 2023 16:48:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1679278088.git.wqu@suse.com>
 <b61263cba690fd894e21d75442556ae2f150f095.1679278088.git.wqu@suse.com>
 <ZBmc3ZqDVzb/hVDD@infradead.org>
 <0ee1de5c-9cb2-cecf-c4be-02cc16bd505c@gmx.com>
 <ZB6sQGoP9dbsgvX7@infradead.org>
 <9581646d-380f-2b55-07ac-2abd37822577@gmx.com>
 <ZB6xcqST8tCA7zxK@infradead.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH v3 02/12] btrfs: introduce a new helper to submit bio for
 scrub
In-Reply-To: <ZB6xcqST8tCA7zxK@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:gf/4l096af04nsWmR1b3DaMR0D9hZ4rGZRbFo+bV9yDAEy3GiuB
 9tCoMhKFMBNcEURD0kD1sr5xglmDZMRBPVOO1ah9FdKVHjy5PCGdzl4Gy8Vipuz4UpJR4cW
 4J57Vix4NIrqAylPPeFQGDzCC2jVUYz+BXwh7wScRPX0ZhwpIqFQoovZUYJ1hmoOl47oKW6
 6hiafVeah0kbRhcrmN2/A==
UI-OutboundReport: notjunk:1;M01:P0:rRhKR5PafYk=;XL0ZKr0ZfNO65bOT03yDQDeEFbe
 cuWkRJUKAAwLMUAxSy9VPuB8EIm9kbdaQTo//4Xfata7rMLTdB6mqaaXoDZIMtj4RI//jrlou
 EY2AhDnjWyhf/uCWhirxMkrLUpiFzku+VXVpST9s6F847E6glYvs3XyOBKmkH+fU78k11wVm8
 JuTxqc7bD79wnWTz4I2Ay/tHYuvSqoq4YbVFPfHbOe7x+yKNSD9cytu8FtIBCxP7cy6WkuVS7
 nRIT98VsAz7/80sQ61DGm0k+p5biFaAKEwQB0bz0TQxbISBfR9zWjCJrinKhM+JjAaQRzDuf9
 AHfRRFzZhJifCjYs5pBidb1Wgf9aNL2RmndgVN9NeCSMwXu/UqnDLL/UiA957lENblYJ5k+42
 x/M+uJesGG9BwblWfN0ccENBBaHsibyUh6Prd+M0SFneyxr83VwoUfqTikg+yMQBWoM6lA7XB
 Ydw2Z4xcRUG/c861BdO3wCcLdxHHGV+OSy5QnZCLKApb4/vSIw6Lz4sHb0J+tbOUOVfaRwF8R
 iHK9gx7nQr8FwsamI/wD/DV9cvne7W8llwZKxdPlEffjkiBwKnn32A0PAE7jjbFyq4PCWrJ/L
 xJ3jF0E24HRs8xLYnPLSuXfZ1/LD4p3JQaudlXu7y9Rt1y4WCsiywYxr6KZapkqofSLNZFviV
 kPAATYsLAV3J/NAAeNlvrMOMi5ssd8O9GcblT68BEQulgbYVaIE/98HZC98FXZohQYHDFtI4X
 OQqODvQ4/5qN2qzjbErBQKX/pLBwSxhCM8jjFV/f8tJu4yTYHdhEyDfe28OnymHRzErC5db9t
 99hqodNTyUkjtew5OPqB69TRtnueKNp9Qo8nlIBNDSNC48uDyQmbL79rY740irrXUy5Mpuxgp
 IkreTAqCHMFf+1f6uqLPCqAeLdDwbhvVpwugaf6Asghzkhz9I4cvVocqZatgAnDt77xLHJmyW
 IMkFoWCxt96avS9lMQw5ZkzoPkc=
X-Spam-Status: No, score=-0.7 required=5.0 tests=FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/3/25 16:31, Christoph Hellwig wrote:
> On Sat, Mar 25, 2023 at 04:21:41PM +0800, Qu Wenruo wrote:
>> No big deal, I can go with the extra fs_info parameter for btrfs_bio_init()
>> and btrfs_bio_alloc().
> 
> I'd be tempted to just initialize it in the callers given that it's
> an optional field now.  I wonder if the same might also make sense
> for ->file_offset.

In that case, I'm not sure if adding more and more arguments while 
almost all of them can be optional is a good idea...

Shouldn't we only pass mandatory arguments, then let the caller to 
populate the optional ones?

Anyway, for scrub usage, fs_info can be initialized at the submission 
timing if neexed, thus I'm fine either way.

> 
>> The main reason I go with the duplicated allocate is to remove the need for
>> nr_vecs, but that's pretty minor, thus not a critical one.
> 
> Passing nr_vecs might actually make sense.  There is no need to always
> allocated all of them for existing callers either, so we can do
> additional optimizations based on that later.

Or we can just go with the github version and refine later?

Considering scrub would be the final major code migrating to use 
btrfs_bio, there shouldn't be any major use case change to btrfs_bio for 
a while.

Thanks,
Qu
