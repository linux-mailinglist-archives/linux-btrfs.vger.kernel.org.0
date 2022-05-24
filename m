Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74837532B2C
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 May 2022 15:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237746AbiEXNVx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 May 2022 09:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237760AbiEXNVw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 May 2022 09:21:52 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E9E4349C;
        Tue, 24 May 2022 06:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1653398508;
        bh=paih7rJPQZr+Ud2AxDEmU0eyi4/GXRL2/kWNShFsi/A=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=W5E90V96IRW+giXs5nmz6wsHy83J3IWuGQrVWjvkBGa6lDdQGNpO6X9MRArCD4nze
         OJRLRXk7odxOn/1BwWDU3T51zgycNPTw/Wss7Xa7K58+c5Cm3FrJ+GgLEDRzUfdY1t
         wuV/JDba3hXcW9iTVHzm10F3DsGvSAIzGfR1Pa4U=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N79yQ-1nlb4H0hki-017SG4; Tue, 24
 May 2022 15:21:48 +0200
Message-ID: <92adff62-5a93-8d04-e869-56f205ffe260@gmx.com>
Date:   Tue, 24 May 2022 21:21:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 6/9] btrfs/157: use _btrfs_get_first_logical
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
References: <20220524071838.715013-1-hch@lst.de>
 <20220524071838.715013-7-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220524071838.715013-7-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Aw7XFp7AqRXj+AN4CCBZAgrsORuqWwBUKyJneAyG6BlJSMC+L2V
 T90ldG3DDdjb4t4U8Nz1tMYp+B00ZETIN7PhJYnDCWykeCywNfJgCHwstH9Sm6Q1g+4QZ/C
 D76xpuYORLoYlkRIaKaed1AZhdnW0fRKqv8eaMgdiZzG7Um47ikpAC/PFj6jwbjth89MHEr
 tmLtPo6Fc9/iGczD/bHbg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:d+vQTqMoH0g=:HReybAxjLnNds+P/uA1CEA
 eEwVGD8rdSO5wdlhfY64xT9Vsl4Z6q7HxIPDvE5cyYqsgKwMcN9D2G7b/XG+Q4GUmmzI3WSVE
 Lfaly1yN5YokGJVWSUz9QdgF3M0yQ1Q35KIg5iocsQTHrirjEw6E708/nUXCP9vY9DfRQ7c5H
 I69N6A/1CLtT4DXbM/qwce/RISduGz4Jh2JO67bINA3OOLJNpsZOr7J7dy+CFJPM+GGQ1zkJv
 lE4st+ex8WgUJfNLrIewtoxpo/h3vejeLyfxfgKwZHaMfpZh+RozIk6ayASwDBFm4uLVyYjrw
 tJesxHCSN9M/ahWohwHy/oKiBYQP19gHAkC8zl8YFI0KDsSggvDWPaGd0ES8q5eBrmBseXizU
 mLilB8vKPYKzCz4bdr1GIlZ1lK1D0uAX4Y9T2xi4uDz/ciGHunqX2c6QX2pCo/ZOPSRhpq9cR
 4aRRIASWc9feEM55UlBaTieU3FFavOeB+jRSZcIbiaq4jy2UJX3FN1cSUA00+tsMcfyofif+L
 CHusXE2QsAZKfu3Ben1giwwXGGFz3SpKcm+uCaEy4bCwxu6gRNnIeuRdDTHVOb1d6W4aHMULQ
 REbbfbrgJy/Zfbn0d7fRdWOzF8CzMQa/KcUbAPLvlN9y1efCjpbn1AKsaCs1AqTvG90jFsRLL
 uqxWsYGY9RLR6S0xPjSF3ytPHHViZe6N41FVDdpTmSwuH9CLbd2WzqhD2QWffZs3kSe+Ue5xX
 J25xeFUHIBRvkWgtk8g7yOy8kkf2CsFeABSfQoJ65ksRKFV6fqqNkauhiaUqkNdfAz5VpphTE
 Rnck8zFglQg5ETSVneGfZa9OZFH/NExbjqZhSrUQ7uOxcmggpK61aGa8HT9zFhz63nhYQHWu6
 Ie8jQLXH6Aqmd3okNjjVE8C4I6xfaL0WmN+w4FjPSPi718BbKAhXzctrH/8eiqVG8taEpBcEy
 hjgE0v7JOkzzsqLXofB97a1mmhLmmvtvRaiSmNtNa3cOg8Tk+6+hcjtGvQv6iamsey7aA2hUw
 BfgguA9WwaI7+dlXxiQEBsSFkbaYfm3UpZ7uOnNqVIytPWzaf+h6/EfNrAGzmeIAWZAI94FR0
 iQcohDBUjLKOchntTFQQswClI5Chk8Ze+EV18YBqFFWw/EP3qd84UlTLg==
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/5/24 15:18, Christoph Hellwig wrote:
> Use the _btrfs_get_first_logical helper instead of open coding it.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   tests/btrfs/157 | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/btrfs/157 b/tests/btrfs/157
> index 343178b7..022db511 100755
> --- a/tests/btrfs/157
> +++ b/tests/btrfs/157
> @@ -71,7 +71,7 @@ _scratch_mount $(_btrfs_no_v1_cache_opt)
>   $XFS_IO_PROG -f -d -c "pwrite -S 0xaa 0 128K" -c "fsync" \
>   	"$SCRATCH_MNT/foobar" | _filter_xfs_io
>
> -logical=3D`${FILEFRAG_PROG} -v $SCRATCH_MNT/foobar | _filter_filefrag |=
 cut -d '#' -f 1`
> +logical=3D$(_btrfs_get_first_logical $SCRATCH_MNT/foobar)
>   _scratch_unmount
>
>   phy0=3D$(get_physical 0)
