Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D94CB6CF797
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Mar 2023 01:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjC2Xlu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Mar 2023 19:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjC2Xlt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Mar 2023 19:41:49 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E6F94200
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Mar 2023 16:41:47 -0700 (PDT)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MTzb8-1pqz5t3zIg-00R2MK; Thu, 30
 Mar 2023 01:41:40 +0200
Message-ID: <b5c689fc-3d34-60b4-063a-c2cdffb2c5bc@gmx.com>
Date:   Thu, 30 Mar 2023 07:41:36 +0800
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
X-Provags-ID: V03:K1:qnvj3vmGGIl6FyKbW2pdyeTZucXHYothgFfghVevz0aAQXljspz
 s/N7O2Rg1voRd25xL7JaAz0EVYE52nbihhqTOhD6J10zi0zEjnroO16Xp+480OhgCk344rz
 RNLMzMkNpekRVSOAOx23IjH5RPcx+3zGkAUNIQjt+v0Oc9ZceGXrQwWQQxyvK/TaZrhE8bn
 3FArucSvt7TkORcTISKpg==
UI-OutboundReport: notjunk:1;M01:P0:gDzCgv4pl3Q=;snH5UCzyjvNw95LBQM5arOpcU3P
 svvXq/rIjBGUOZyIb55hzn3XNpzPQFPhmh5U+sH7pbMk/spMVn1JACtleY71Gi+igsYcAJHMP
 r82l0OA1UxE4NDUAfjtzX5GpjTn5aq7JbLsNZXhzcrJxZZffvL4XZr6bbwQuQirM5PT6A09vP
 vFGQ53Wz8+Xev3We2ZHjehHiIS9N8PkquGdd/YI1vH3JDt93629s47NQzwegM5WRPiE5JFqfd
 xYt3HXP8XZnW185PdmFaCbRT4XY3Ta3N9Hh3UOjEM8A3qJbFZKdtL8QbCEf+a9clwhY462A8+
 3PhaaBJzQIVPlVqHF5bw2tkTL6H9roWJo2rC5gDPJJsb6aKC+VYqqfBZddv0VSMXuL6i36rsc
 1+ZO4mW7SHlCNoVUoU5qBfbFbPyWX5w35oA2MXbYf36YPnPfOsNMR7/aLon90SNxbQBvcNq0x
 nU2VzKmbRU4ihbvaclq0N+0ljKHUiansgI1AVKfkB9CjcksOb5rs2IoDYpOdxRbl89zKgBLhu
 foy7tagDBSk9aAMfOh5iouzO2kpmyc78/R6IDXBvF1QcBMGwZQvX48H8h1rZzEo3Fd/pive0W
 kOdm+fnRcn6I5hus7P7ys7qe0OpoED5sVqsjDxTX3lX8SF6cWGUj9JAt87f0SvaNNbh9DwMNi
 8alPUzeon5sEeRBysnG5Z+s1FSsp4r/GUG6mL+KGtlgoCMTueqraNft32qN3jszWxmyuE/h63
 S0birat+dDdj3w0v31GsODjXmlgwvo69X5Asms0EwlEi3zk0A5QA15S+GfQvCC9622nhbJKZw
 6rQyRXc5RvcGtUBeAKMSET6bb7g2/r+lFVaYmLEolciwk4fOeHJSRECD1lk0nTUCant+D0UlZ
 Gcm4SmKoUx7ud3EN+wTVT8T9Lbf5WquWLvbuyBI7JEq0lRTQbS/2g9PzS0hjo+fCztM+oEuqf
 nFlprxLNKgGgOzQUNVMLdO7RPe4=
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

Would address this in the next (and bigger) update, sorry that recent 
updates are not yet taking the higher level changes into considering.

Thanks,
Qu
