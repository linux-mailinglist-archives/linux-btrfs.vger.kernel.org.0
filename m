Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1142E64C0A8
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Dec 2022 00:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237135AbiLMXcS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Dec 2022 18:32:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237122AbiLMXcO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Dec 2022 18:32:14 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74571008
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Dec 2022 15:32:12 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M3lY1-1p5VbT1sTj-000uQb; Wed, 14
 Dec 2022 00:32:05 +0100
Message-ID: <d4124214-f09b-5089-38c8-47f29a07b7d5@gmx.com>
Date:   Wed, 14 Dec 2022 07:32:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20221213084123.309790-1-hch@lst.de>
 <20221213084123.309790-6-hch@lst.de>
 <083cd81a-644e-a054-80c1-1b3b902ff6e9@gmx.com>
 <20221213132433.GA21430@lst.de>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH 5/8] btrfs: cleanup scrub_rbio
In-Reply-To: <20221213132433.GA21430@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:nwf9hirlYQCUMdIbefnNWVuvZoX0aOH1Y7xpYlRzTdm9gb/q372
 X8abu8FZ9+nbQXwII+DNOBrEEFuUqd5EFL2qmit1gm7AePmvL2/y/DkV1pFu8COyv+1pR+A
 h7cA6UqSw7gsdUDnnGOmgiGuZ3BC9DsEFQF/ipho2jqBhZRettTtVSpNo0d1ppyx2UujBgK
 YJtYIHbStHh8GSDhYMprQ==
UI-OutboundReport: notjunk:1;M01:P0:dBxOP9Skudg=;lj8SFIKRxmPFUHSNaaWfMEwU+Nx
 fCp3o9QX3+vEdKeKTwpzgHb7qgNJv/UDnOc7ULWPyRmlB/pNLlLAunmk9WbXMc12+zP/N/XCg
 1I1N5R8uvLJKUm/g9hVq6f06BMfGYQvRPqlqxAES0hbDNhUTNxDuK3kfQv2LJfFcbtZ/570E3
 GNSLCmIR3n2OdwydoUBY6v1GTXbn234YdYdfhZsRwy8jCt3DNPIDgwKc+Nz3HX6hn547MNPLW
 lTExn3Mo5blMv/mlJWWxyDPssWKryl769UsNXfbtHJtshZXQZ+wuJfJRBIcpED6ZUmIklAWfH
 b8uakG2tirVa/xG6a1UOxk7rnFaGkzACS6OnOLCeU/92oeQJ8drRGmrVuV+9NoWvO54OAipre
 Fg7xVD1HegAf7Q64Y9hTZ6m2GY0m5HykMFsWZ39n7HnZNj2XhzOyJwcrbfbNcsu4Bf0PAa+TY
 MmwAljMFwVGdmHspGkVA902VIghzqyfl+ChzzBIy/KW79qaY2neVK9oBwU1QhB7K1Zz9oumBk
 W8UOvDEYrGoX+MhzbStuA3sB/48MfVmPpHNRf6pE2OMVWqMOHT2IG6prQKZf2IvOjtLfpFL51
 9kmNLY1W+J9VX4/6Y6j16g+ZF/h68w1NtIpmIzGeRx8C/MtGn4oPFLf3AkWmzTOaB9OklsVAj
 ZL9a4Q6i1drelmTmUhgMRSYPBR2XAjOlLWWeLfmg4T3QSRFs4kz508fGlgZZRQRU1/s5gXdGn
 2pm/6cY4jOh05hzSxdnMMBvg7s7lXVc0RTHhyIvmVrUKwVW55WcdueXOFAtKGIGqhlcbapXWF
 5EfMQ6fj/zBYlfXZxnJIviUmBsRND9kyrHzpMdRR0R1EmWNe897tLT9T4+8rsuWvZPcpK5nFQ
 ziiShjad2I+F4Ku4BAc1mJmNaasdtF1IOtWnPuBSgIU3Nl6Z4NqTw/nTywh1uxT/V2ySSKbCZ
 8TCTxWhX0RtcOyLokomjdDj7DNY=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/12/13 21:24, Christoph Hellwig wrote:
> On Tue, Dec 13, 2022 at 04:53:33PM +0800, Qu Wenruo wrote:
>>>      	ret = scrub_assemble_read_bios(rbio, &bio_list);
>>>    	if (ret < 0)
>>> -		goto cleanup;
>>> +		return ret;
>>>      	submit_read_bios(rbio, &bio_list);
>>>    	wait_event(rbio->io_wait, atomic_read(&rbio->stripes_pending) == 0);
>>>      	/* We may have some failures, recover the failed sectors first. */
>>>    	ret = recover_scrub_rbio(rbio);
>>> -	if (ret < 0)
>>> -		goto cleanup;
>>> +	if (ret < 0) {
>>> +		while ((bio = bio_list_pop(&bio_list)))
>>> +			bio_put(bio);
>>> +		return ret;
>>> +	}
>>
>> Do we still need the cleanup? IIRC after submit_read_bios() (or be more
>> safe, after wait_event()), we should no longer touch @bio_list anymore.
> 
> Oh, true.  submit_read_bios does the list_pop, so we don't need
> this here, and in recover_rbio either.  And looking at it a little more
> I think the are could use even more cleanup by:
> 
>   - moving the wait_event for stripes_pending into submit_read_bios.
>   - moving the submit_read_bios *_assemble_read_bios and stop passing
>     the bio_list entirely, which removes all the confusion about
>     who cleans it up.
> 
> What do you think of this series (still needs testing before I can
> post it):
> 
> http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/btrfs-raid56-cleanups

The code change all looks good, I'd just prefer some naming changes.

One personal thing is, I'd prefer "_wait_" for functions that may wait 
for IOs. Thus submit_read_bios() may be better renamed to 
submit_read_wait_bios().
(bios means it still directly handle a bio list, or just 
submit_read_wait_bio_list()?)

Another changes is, since there is no bio_list out of the 
<work>_read_bios(), the "bios" naming can be removed.
Something like <work>_read_wait() may be a little better.

Thanks,
Qu
