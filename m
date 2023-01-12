Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06DDE666B37
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Jan 2023 07:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjALGcI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Jan 2023 01:32:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjALGcH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Jan 2023 01:32:07 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69AC23BEB1
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Jan 2023 22:32:04 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M2O6Y-1pC0J6498Q-003rSh; Thu, 12
 Jan 2023 07:31:59 +0100
Message-ID: <d038338b-9611-50d7-7e3f-67dc98e6f2e6@gmx.com>
Date:   Thu, 12 Jan 2023 14:31:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] btrfs: keep sysfs features in tandem with runtime
 features change
Content-Language: en-US
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
References: <ef0efdacd9bd53a55a02c6419b9ff0d51edf5408.1673412612.git.anand.jain@oracle.com>
 <98540b70-c7b8-5340-7a4d-ee6f43f6babf@gmx.com>
 <067d3b1c-8510-81ee-4c90-02c6cbd74f7c@gmx.com>
 <09594c06-c1e5-4d11-7b6b-48abd51dc225@oracle.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <09594c06-c1e5-4d11-7b6b-48abd51dc225@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:NxvOaoD9usIlBXwpaAbqPzgcccFYWTTxu5nj21rys1Egh+AfUiX
 zzDefu80awxuwO1CL1Mp8ZdcOgxW9tI2vuhbKq8kyGT0QgvHtvYYlKV+9M3afYRElJOcI3p
 SrYWhnpVSE1b0SdVhCLcrp2oXDwXGogxTkb9Ej7CTone+5f48W9u/gR/xl44PqlMk8ptoUm
 vBZYNAnUA2w47uOIIQFVQ==
UI-OutboundReport: notjunk:1;M01:P0:lkge2iuerzk=;vOMNFlICTfAUCOeuC9Z8n6z6DB4
 9zfuFpbJZMF0QalbcMS49BjhpPAuKnPzheRDsl+dXeoZb2d+8O4BXY73MVaXRY1xum9E7LhSP
 hBAxhQICzwH8xCaKr1aB/JGHMirIaWHzpri4iKHe3RuL+wGIZ0xRG1/FjFaXC5SSvC3a7WF8M
 9LuyohuwqZXPYy/Qx64q2KOFWyM86ljasscDdWc45uS/GWwbuX5PMeQ82fheqrqG+HgJ8YOYS
 n8nkMs80PgY91Rz+93yj2xPLko/66+h4khu0a63mdbPBZzQGxPoazyTSnLk7VwgOjHGj4AGtm
 K3P4aXmRHGAYC55/MhW7skypyONnsKBuVe5hjgXbJdKVvmD26giEgJsPaoELSgWD3oZ7hqms4
 h1UssNMdwL0WHQGQvpaexS+P15Qfzfrycp4sF8h2ybsPOiMRsQs57dUyY9L5vdHggg7wGdmxO
 SnypW0xYAiU95rkfUcBEEVpd2SosIsJ4xVqYWZAtbYKIjCArekFeMOnosampKPMkCR3z6znoA
 6GBqdzZdT+EhHZ5vpm2liTmlvNTkXBkEBR7R+Zwy/S5haPD+kHQy+ix8O0a0GR5dZKMpv4H/F
 +dVX5+3BoX1SH4ZG8LncfhoIseBmjlelodnAGWeDuIx2vhR7L8HGY6e1sHH3CH2WAq2qCzBGF
 EwxzV+0lAI5we9CH+15FQQ/ilKufIAiA1vuCGRJLLEVXlaIJQ4SIAOM14B67RLxROjhWLypRc
 2Bz9O2zzGX3KUj9stFXoNxObJj6nOU1KdzduJleb9hGuats2Der68udVmiYTNnPrw6EXq7D+8
 VtLZTf2VhjHXSh5s+i5P5o7h/aeFLaAKHKmcl7T6M947ub0FaS08eifbh8Aw8Fso3e6TEXeE3
 4SNC8Zlr9h3vUSwVhb/+mt5l0xdeFTtvyO73vgwfeGQWO1E1SJpKVTTgYLkrEeC6g0wnb1mRv
 ddHJZIpBBQTalbHTfzm06Wj/oEc=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/1/12 14:08, Anand Jain wrote:
> On 12/01/2023 10:35, Qu Wenruo wrote:
[...]
>>> Oh, I found this very confusing.
>>>
>>> Previously features/ directory just shows what we have (either in 
>>> kernel support or the specified fs), which is very straightforward.
>>>
>>> Changing it to 0/1 is way less easy to understand, and can be 
>>> considered as big behavior change.
>>>
>>> Is it really no way to change the fs' features?
> 
>   Sysfs files (attributes) design doesn't support dynamically altering
>   their presence though it is intuitive.
> 
>   Another option could be to deprecate the /sys/fs/btrfs/uuid/features
>   directory (kobject) and create /sys/fs/btrfs/uuid/running_features
>   as a file (attribute) to show all features in plain text.

Nope, the attribute group for mounted fs "features" has the 
.is_visible() hook to determine which files are visible (aka, created 
and deleted).

The call sysfs_update_group() has explicit comments for it:

  * Furthermore,
  * if the visibility of the files has changed through the is_visible()
  * callback, it will update the permissions and add or remove the
  * relevant files. Changing a group's name (subdirectory name under
  * kobj's directory in sysfs) is not allowed.

Thus it's a perfect match for our usage.

Thanks,
Qu
> 
>> Furthermore, we have something left already in the sysfs.c, 
>> btrfs_sysfs_feature_update() to do the work.
>>
>> I'm working on a patch to revive the behavior, which is working fine 
>> so far in my environment.
>>
>> I'll address all the concerns (mostly related to the context) to make 
>> it work as expected.
>>
> 
>   Hmm. It should be ok, but I am afraid it would be too pervasive, as we
>   have many dynamic features. I am happy to review your patch when ready.
> 
>   Otherwise, I have a patch to clean the unused
>   btrfs_sysfs_feature_update() function ;-). I will hold it for now.
