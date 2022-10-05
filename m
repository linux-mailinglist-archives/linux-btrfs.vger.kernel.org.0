Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55CA55F5088
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Oct 2022 09:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbiJEH7e (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Oct 2022 03:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbiJEH7I (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Oct 2022 03:59:08 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA7D6DFB1
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Oct 2022 00:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1664956733;
        bh=kfUNrHT1EV6gAX8ZlcvP4UrZGT2kSBuD/fV06xKaKEE=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Bm7ij0W6xN5o84cePa4UJUtUiWnxYQZmjTLcoK99XprvrlycsVx3FUZrDCZaXaAm5
         oTaAdSLACJcXn4yKaEW7EWzQAe4yOyHzDeHFfQipqzz2pfrWaR+J/iNciK5F9dS7sX
         8ICeny+7f03Z6V578oUVOO5HmfhqQvLKJwL6yV/Y=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MhU5b-1pBBNv0R0d-00eawz; Wed, 05
 Oct 2022 09:58:53 +0200
Message-ID: <3f0ff6ca-76f0-9e4c-7a3d-7c96ccafff57@gmx.com>
Date:   Wed, 5 Oct 2022 15:58:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 2/3] btrfs-progs: mkfs-tests/025: fix the wrong function
 call
To:     Wang Yugui <wangyugui@e16-tech.com>, Qu Wenruo <wqu@suse.com>,
        David Sterba <dsterba@suse.cz>
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1664936628.git.wqu@suse.com>
 <e89c8122b8b999737e4164467b2b6164daae0575.1664936628.git.wqu@suse.com>
 <20221005144310.DA9C.409509F4@e16-tech.com>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20221005144310.DA9C.409509F4@e16-tech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:P03Wgg/VnQSH91FXj2vXi2Hq1f1ZkfXdcezvuES+Scsh327Qr0V
 ud/cCf+1E7q/YLoOSrpIOyMn1OloKFoLWT8ftB0UOkkhyYFy/CFEWbCLopNNQCjWvN3nAAi
 oQ9Zq9eQJmfIhHqpyPcgyzrq54kknEmfOc3dF7Lx1l8vVWvGiDxXOcvFIrfCl9CkNbT5w34
 9f7osDUmwJfvavlkbFEhw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5lU9aTVDFGk=:V/l5GIo9Z+ljgWsSw+2ZX3
 TJt7fgyFGMPinQPS135F5ZMjgYqs+SfWIlXJ/6fsLrpBd6Ddwfi1ayInLPqf604NgrRLjchsw
 vqdywafQ0oYnhy+g1RpJeem6uufnvRcAAaK5jaWmAG0sjftwrp1KoAksC33m3vX/e/TvObKdj
 8XAcb4762wslofmJ8GZj/hn6HGUgPRN3bc3sf4gm/3w6KlLRABzOuzOxVSKsUQ0Bf6R+UzwAS
 2lsCprEW/OOK9kxgl/m/MfakPwLCbX/HCIyQVhbJGS1c8hJyhTG1OUG4jbNigLEUW22205IuB
 jXA0DNktRsy4XKCqRfRCnKcfNmgrZNbQ/nHdBl19JbyKxrJnReMv5ktxw+pYu3Us0IAgmqcll
 NVkfz9g4QUIoRls1egSFdWxSa/a1hwjVo5lfZk2SXLN6e04HIaV9BYX9sC+sb870iImZzL3jq
 W2NsVQz4PWby5Ziwn978xMF9K+fyfucQtWUEMKXtbxymnapDN5kjl/fZ672zspj+tW9pNQjrt
 2toCr/TefLZ+WtuO6h5lBAtz61i4+cgVvlWEsMHgh6TBfc/6MM+x/p89mSXbeONQX75jMnX/a
 L5XIF0+RPzlVhLTIuHPOsckzdFqpPWHATC3SRdswb+tlNvfsjnfLYiu7YelgvEKboem3FMQAz
 p8qBfHIoa2du4pjtgN/EIlHON26A+q3tioib8gcngZxzYlmBBUT23j0V+i1PUNBYscIeb334t
 Reu1wwZKouZ77Xdff9JhPWfY9AEg/n21eGH6GAYA83r4ftGxKX0fspHFQ3tSIsyNiJuTLjvBY
 pqTWu2tEZz4TIQeYKkN1vqpvfTNzbxAjG49zs1P42yD2B2hgE8HtXC9YZF8jflV1XI0Sqbi7L
 HR7pB3dLz0pjnpXCyplgkuI//a1a4wVYJlPZ9RygP+ujr3qZruL40fxXTxj+w3VICX0VQb1Or
 pJF1fj2AGkkQkpFygZV1YXaeEgQi0I6oNzbArQ7rt81dbNqzc6buYb97P/a5T1QwQawQWzavm
 H4X0MfSPqkiFl9rEP95kzZe8FpDZ5mNLbpGT3S6phRsj3z/nS17yOqYrKj88YT6Q4RBiMWEM9
 KYJ/u8OtNk4BsTLdX85KghOKNnSB/OQiCysOZXcghjJo3/7iAlRFrQEQXeC6E7LEmdiSzGwAj
 uqN84OVOFLnvbmM9VJ/PTvA6vq
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/10/5 14:43, Wang Yugui wrote:
> Hi,
>
>> [BUG]
>> Btrfs-progs test case mkfs/025 will output the following error:
>>
>>    # make TEST=3D025\* test-mkfs
>>      [TEST]   mkfs-tests.sh
>>      [TEST/mkfs]   025-zoned-parallel
>>    ./test.sh: line 11: !check_min_kernel_version: command not found
>>
>> [CAUSE]
>> There lacks a space between "!" and the function we called.
>>
>> [FIX]
>> Add back the missing space.
>>
>> Note that, this requires the previous fix on check_min_kernel_version()=
,
>> or it will not properly work on v6.x kernels.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   tests/mkfs-tests/025-zoned-parallel/test.sh | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tests/mkfs-tests/025-zoned-parallel/test.sh b/tests/mkfs-t=
ests/025-zoned-parallel/test.sh
>> index 8cad906cd5d1..83274bb23447 100755
>> --- a/tests/mkfs-tests/025-zoned-parallel/test.sh
>> +++ b/tests/mkfs-tests/025-zoned-parallel/test.sh
>> @@ -8,7 +8,7 @@ source "$TEST_TOP/common"
>>   setup_root_helper
>>   prepare_test_dev
>>
>> -if !check_min_kernel_version 5.12; then
>> +if ! check_min_kernel_version 5.12; then
>>   	_notrun "zoned tests need kernel 5.12 and newer"
>>   fi
>
> '_notrun' should be changed to '_not_run' too.

That's right, I forgot this as my previous patch would render the path
unreachable for newer kernels.

David, can you fix it when merging?

Thanks,
Qu
>
> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2022/10/05
>
>>
>> --
>> 2.37.3
>
>
