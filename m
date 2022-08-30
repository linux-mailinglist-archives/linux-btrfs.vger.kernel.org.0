Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C694A5A706F
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Aug 2022 00:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbiH3WPZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 Aug 2022 18:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiH3WPX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 Aug 2022 18:15:23 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D5C29CB3
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Aug 2022 15:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1661897719;
        bh=1JM93rndJIAO2RbGdcTboxeo3bTCbDt4pjD3RmOUNlI=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=KyO3re2cytjHSqDy7cg8JThUTkFnRLHLTV99UBjoc5GRZEXk4GROWPD3KqHzmdHtz
         77OMDj8g/WcLakNcQMkVFw9A4b4gvFAkHMTDQEluo+M2DprSzeoM4fIiQkfpDwcYUh
         XJmV/aK6i2so03Pj+Mg0xlmR4tgT3wgmwlUXrjWU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MvK4f-1pK9Zf0Vsn-00rEid; Wed, 31
 Aug 2022 00:15:18 +0200
Message-ID: <99439be1-d7af-5db6-7eb7-7bac5657ef05@gmx.com>
Date:   Wed, 31 Aug 2022 06:15:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] btrfs-progs: fix eb leakage caused by missing
 btrfs_release_path() call.
Content-Language: en-US
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <043f1db2c7548723eaff302ebba4183afb910830.1661835430.git.wqu@suse.com>
 <20220830171730.GB13489@twin.jikos.cz>
 <72b31d43-07fc-6126-b326-5110315ae342@gmx.com>
 <20220830214902.GE13489@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220830214902.GE13489@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eQ9R0o051t/kzZ/znDL5J6STHemfDM83hRm0MzewbFaYDMM3fJk
 HT6VGlnw2qcS8fL01Q/0ztlSl/J6NAkFXtIzX1wDg2H3HinFlAVhWuENBkyJNtSCf8hu4eY
 B1flbuliDnYUakjxzQKDGyOACG2Bm1JUp4kLWjArRb5Fom+CBhUykJ9FqHKjv9BS+HQM2/7
 rrvCecAV8LSwluANjlR9w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HNCE2kfl8BU=:pdMGF6SsP2RbLCdLEJ9N2U
 QktiE150IuGlUT0jFvDDQerBBpjlPHrdkBNRDkTX1FjOC6GVg3GfzRrI+jeMc/GdDH5rFwLNK
 egM4064k8s0x08/6M5nUnShiydGJeRRbYOxcqnrZujF9oVX/+eCrVufeav/5KREaRGsZIyvZk
 qYX1Uz+GPPffiLNBcmXjfFwoTcsHsDMoM17rew64sE034NGsJkfdp4FC+WKJ+Z1hJ6SIKhMIt
 ngNVVKyaN4DU5Vaa8BjFPf2QtWUgf2zhsUNBOjUkWqTsKpGccNO03YgNTP/Z3QJuzhSBJVdAU
 RnKkmGtxLhyz4l+pDUFZwF152h7POp4S+RqqDnhaNl5jTFtjEe7Ozui7fijoDUDHW8Csjxw4R
 M2yk+FkdYbWmWgdHhBJpoIk9z7vNY9GUVf6OijiGy3UMri5eRkCfln8ErYLkg9tuu02nfs5+d
 EdhiDKXZPaRiSmfmFsCIl+Ywz+juH6lrNBrH+y9PyVZdFe9EFhh4TAWBdYl6jCsmWf9oBrV/o
 8QV284VZKiJvIXzI9NzOgg17r41KzmPpLoJMgPkF22twKemoJCX7mAHYOs1NkfnQFW/cIJOlp
 e4UCz9/ToZi/VZ+lFmL7a/392Xg42vBzitiHD3fV23nSa5UlD+k0tuyjGnaCdmd2Csnl8IJ39
 goDkqbwKhKuVz87fvYF9nENScB8GBHP9MsrnujabdaCPZpXiugT6pRA8f95i8M00+VhWtl/Vo
 NqCKufh7NVFdujMeFtGKkF0cm/fHtYaPObpC0JEsIs6cQ5jSYVCM6m0rgjPddBslYddyQ6jz/
 Fd5BvRppqvDnwWZsXik5IhioCpzjp08gWoR4rYFyuqH06YAzP1qSeISjm+jL0t0V6rzQiytJL
 +VclZja1+POWZXu2yCMpYIXuWqGzaBmFLoyl3EhQbnrtTZzPedH9nm74DabLGS+TSZtFPv3MA
 cfjXUrS/hRNsL/VOjjFcftHsSXL+FNIRtfU0yd1MedtetcMzyIjYaONNQ9KkH/3MmXmDupgvo
 l0x4EbY+MPp/wBPY1BORmqk/EWxCFtDmBuvSoZIACzblodqZm/x3cM3xXNhJqX2FqoEUJHva2
 0frOt14XtDDrT31aeufWO1uoTOj9Fk7iSkOyP9wbJfck8DQj3tf124ksg==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/8/31 05:49, David Sterba wrote:
> On Wed, Aug 31, 2022 at 05:49:13AM +0800, Qu Wenruo wrote:
>>> I do that because that's the preferred style, but not all people respo=
nd
>>> to mailing list comments so we're left with unfixed bug with patch or =
a
>>> unclean version committed if there's no followup. Or something in
>>> between that could introduce bugs.
>>
>> Another thing related to this on-stack path usage is, do we need the
>> same change in kernel space?
>
> No, in kernel the stack space is a limited resource.

Should it be a case by case check or a general recommendation?

As for some call sites which is known to have very shallow stack height,
can we use on-stack path or just avoid it for all cases?

Thanks,
Qu
>
>> And do we prefer on-stack path initialized to all 0, or use
>> btrfs_init_path()?
>
> It's initialized by btrfs_init_path everywhere else so for consistency
> this should be used, though the memset 0 is also possible, there are
> only int types or pointers in the structure.
