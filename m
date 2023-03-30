Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68E216CFBBF
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Mar 2023 08:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbjC3GnU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Mar 2023 02:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjC3GnS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Mar 2023 02:43:18 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D4540D9
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Mar 2023 23:43:15 -0700 (PDT)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M7b2T-1pn07j0bV7-007zR6; Thu, 30
 Mar 2023 08:43:06 +0200
Message-ID: <152b4cb0-db59-24d5-b7ee-4ecc57480fbc@gmx.com>
Date:   Thu, 30 Mar 2023 14:43:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v7 03/13] btrfs: introduce a new helper to submit read bio
 for scrub
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
References: <cover.1680047473.git.wqu@suse.com>
 <79a6604bc9ccb2a6e1355f9d897b45943c6bcca9.1680047473.git.wqu@suse.com>
 <ZCTKvcEccAreV+6g@infradead.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <ZCTKvcEccAreV+6g@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:j+7XsolGksUHfqEP7ud7ilvs0OQNcJiW44dWgRP75fBKyxc3hhZ
 phvFczvd4k3WPGnTGAoGf6glEyMVSG/7RzDPdWdOcxXpFD9u3qNcxs/Qgl2ZVZre34aYffG
 rxvROEIGF0ylHyO3NDK3+x5+FT4GKmF5lfZy1GgAHIp2Q/hbjHKMinm6HraZFk5DcS4W87J
 p75YG9yDKSxT+WT5O1RJg==
UI-OutboundReport: notjunk:1;M01:P0:td2XZtPvuk4=;pfiT+8IYdx6NRsl0kuAFfpXYT+2
 pgtJjpCglZfj4MY01RWqIY2RN2291Jy7ny4obLS6cqqz+E33OpHSKw7xdsMC9Frgf+WD5AI5x
 1GlM0Zlbxg+ItjUub4AhqDa6CiRrH47lrjJaunhwtWksr2X/lEWuvBs7t/4oJ5lErTxOUBOeN
 V0buD0JSHmk5R6BI2i13MVKjrWOWqYmOL8HFKg1UDY1qbQEGcz5e8rxgEKVAsX1c4hzdpaM5C
 ozhB7vKrOPBkFmYHcYNbN9us9HTiyR7LeX+CgkB246MpLBaR9RGm67NNvWDkswF4LaY0Puorc
 t1lUJeerCoGmfyECpcNrL77OoGfjep5KITzQLe+t8rszKIl5NZAt2n+m68Yars5XlciNVI5t6
 Qk3Aqfzch/vC4a8KPOnMS9V/KIo0mUONz6gOxYEsbiAV40fk0AbGbUWJZrN+V48teYCr+V60y
 8yEFBD0NTFeMJ3lXeeocEce1uaip5flfWOzt4w8f2lnBsOPm995WUdmwhS509Ygpkw9l2ooaa
 lAUXCOSJeaKEBMapH0fpQ93rxO1vGYtrt6nFrohZdUs1NaDi9veTDxWcTH8a8OIXoHzALx1Y9
 odnoNXrlt5JsngACu7OtlgQSJCzS4LuN4uxbqGppWYppXd21BXhRG1hwvciM5P/evwO3Wp5Fw
 dUzVrMw70FvMII5WEA205PhGSdFEcX/PQxvhfzMe5OyEE+ZGkPllz0ejA9iKUdU3NBZvfm+iV
 bZEaEmSAAOO8KA+kQNykKUP0+7N2iHXzUTvUw47qIKYHoDEZEx3upx3LrzJzb5bwstWPwNyZI
 dtpCb5h4uO6ZLMUgLclGjbRhsFFIJnwBlVrA6l3fZex/hwzGOcsvOpz10eokSH834bYAg+1jI
 gqRzRNdRUod1TOhM+hM4jssHq0E7Agr+rnlB2o6lfryGvU0uNNAnVtzerhfWVL5UvCRbpDZCB
 9jA0pmDmQlTWebPnmFCkimOvIzc=
X-Spam-Status: No, score=-0.7 required=5.0 tests=FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/3/30 07:33, Christoph Hellwig wrote:
> On Wed, Mar 29, 2023 at 07:56:10AM +0800, Qu Wenruo wrote:
>> The new helper, btrfs_submit_scrub_read(), would be mostly a subset of
>> btrfs_submit_bio(), with the following limitations:
>>
>> - Only supports read
>> - @mirror_num must be > 0
>> - No read-time repair nor checksum verification
>> - The @bbio must not cross stripe boundary
>>
>> This would provide the basis for unified read repair for scrub, as we no
>> longer needs to handle RAID56 recovery all by scrub, and RAID56 data
>> stripes scrub can share the same code of read and repair.
>>
>> The repair part would be the same as non-RAID56, as we only need to try
>> the next mirror.
> 
> Didn't we just agree that we do not need another magic helper?

I have changed the code in github repo so the read path just goes 
btrfs_submit_bio().

The patch adding bbio::fs_info and adds all the extra skips if 
bbio->inode is NULL:
https://github.com/adam900710/linux/commit/23c5a1bf8ce98f205de574a15a0eb0518e56e80c

Mind to give it a preview?

Thanks,
Qu
