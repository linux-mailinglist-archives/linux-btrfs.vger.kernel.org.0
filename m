Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3ABC3077
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Oct 2019 11:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729388AbfJAJlg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Oct 2019 05:41:36 -0400
Received: from zaphod.cobb.me.uk ([213.138.97.131]:54442 "EHLO
        zaphod.cobb.me.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727130AbfJAJlf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Oct 2019 05:41:35 -0400
Received: by zaphod.cobb.me.uk (Postfix, from userid 107)
        id 4A8E29C3A8; Tue,  1 Oct 2019 10:41:33 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1569922893;
        bh=uDLzM9jvGFYq8yS52XcEhJnNYLxZi8E8wjtnXO0Fju4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=PmixjPwDw4H05ngTuv0lWeUNG1KSBjayugn+f17kCGnUGEXs1mIn1uPmq6nj/DTX4
         1OqPhurjf4mZq5UZ3lU8jnzT5SW+8Mh+re08G+wybXQ48Ukw1OYruuahYar1JqjLWj
         E0+Xm3BTf3/Tj/ivqu9tPNflApp/1kqfrP0EHk3OfjcRpVaKVcUTb8QEj7R8sPYj6m
         RipVxFaUwUTA4AD+8Gqks6sRG07AOVK8ywLLawKrg4PYWxD1wiyCihK2ZMIzbUMDG2
         kPl/+dvl5v11EhhtQoMZylcv1+qWem/UZmOyYIszhLpyHNsjaybCb/3YRMY2qM6U1O
         0lvvjtw3IQHBg==
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on zaphod.cobb.me.uk
X-Spam-Status: No, score=-0.8 required=12.0 tests=ALL_TRUSTED,DKIM_INVALID,
        DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.2
X-Spam-Level: 
X-Spam-Bar: 
Received: from black.home.cobb.me.uk (unknown [192.168.0.205])
        by zaphod.cobb.me.uk (Postfix) with ESMTP id AEA209C314;
        Tue,  1 Oct 2019 10:41:30 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1569922890;
        bh=uDLzM9jvGFYq8yS52XcEhJnNYLxZi8E8wjtnXO0Fju4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=kzedSINSy8lnhgImgSUO8uCZ01ATi77WvDMeRECxhAUeluC4ab30rn+VicnIeuIIT
         ZUoJ14uAxJ1Q1UofgFiBd2eP0WaVTYiU/mrBcd43G15yVHtC3XcGYkaI90DlwTXmaS
         XyYI94fLLnGmiEJ5ZVH+Qi7axpJj9ZnyPRvRqK7DmtH9ctiQUk5hD7TKE8TIrW0MAR
         4daaV8o88341eA2NXzlYSqTnQU4c7ixGBjl+K6UqpPdkxrzXowRYpgKCIHDyHtdj4L
         hXjv5i29ndEDA2HRHg6x++lArQ1inKAPIMnw/YrbBf8cVTkbmm/wLc/BVzdIHI6YPT
         uhKpKwCKRHYVg==
Received: from [192.168.0.211] (novatech.home.cobb.me.uk [192.168.0.211])
        by black.home.cobb.me.uk (Postfix) with ESMTPS id 76F3E5085B;
        Tue,  1 Oct 2019 10:41:28 +0100 (BST)
Subject: Re: [PATCH v2 RESEND] btrfs-progs: add verbose option to btrfs device
 scan
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
References: <1569398832-16277-1-git-send-email-anand.jain@oracle.com>
 <1db59f87-9abc-c0ca-a086-3c65eaa5e629@oracle.com>
From:   Graham Cobb <g.btrfs@cobb.uk.net>
Openpgp: preference=signencrypt
Autocrypt: addr=g.btrfs@cobb.uk.net; prefer-encrypt=mutual; keydata=
 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 myxb
Message-ID: <b8929b52-817f-beb4-d371-188d0edfba91@cobb.uk.net>
Date:   Tue, 1 Oct 2019 10:41:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1db59f87-9abc-c0ca-a086-3c65eaa5e629@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 01/10/2019 08:52, Anand Jain wrote:
> Ping?
> 
> 
> On 9/25/19 4:07 PM, Anand Jain wrote:
>> To help debug device scan issues, add verbose option to btrfs device
>> scan.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>> v2: Use bool instead of int as a btrfs_scan_device() argument.
>>
>>   cmds/device.c        | 8 ++++++--
>>   cmds/filesystem.c    | 2 +-
>>   common/device-scan.c | 4 +++-
>>   common/device-scan.h | 3 ++-
>>   common/utils.c       | 2 +-
>>   disk-io.c            | 2 +-
>>   6 files changed, 14 insertions(+), 7 deletions(-)
>>
>> diff --git a/cmds/device.c b/cmds/device.c
>> index 24158308a41b..9b715ffc42a3 100644
>> --- a/cmds/device.c
>> +++ b/cmds/device.c
>> @@ -313,6 +313,7 @@ static int cmd_device_scan(const struct cmd_struct
>> *cmd, int argc, char **argv)
>>       int all = 0;
>>       int ret = 0;
>>       int forget = 0;
>> +    bool verbose = false;
>>         optind = 0;
>>       while (1) {
>> @@ -323,7 +324,7 @@ static int cmd_device_scan(const struct cmd_struct
>> *cmd, int argc, char **argv)
>>               { NULL, 0, NULL, 0}
>>           };
>>   -        c = getopt_long(argc, argv, "du", long_options, NULL);
>> +        c = getopt_long(argc, argv, "duv", long_options, NULL);
>>           if (c < 0)
>>               break;
>>           switch (c) {
>> @@ -333,6 +334,9 @@ static int cmd_device_scan(const struct cmd_struct
>> *cmd, int argc, char **argv)
>>           case 'u':
>>               forget = 1;
>>               break;
>> +        case 'v':
>> +            verbose = true;
>> +            break;
>>           default:
>>               usage_unknown_option(cmd, argv);
>>           }
>> @@ -354,7 +358,7 @@ static int cmd_device_scan(const struct cmd_struct
>> *cmd, int argc, char **argv)
>>               }
>>           } else {
>>               printf("Scanning for Btrfs filesystems\n");
>> -            ret = btrfs_scan_devices();
>> +            ret = btrfs_scan_devices(verbose);
>>               error_on(ret, "error %d while scanning", ret);
>>               ret = btrfs_register_all_devices();
>>               error_on(ret,

Shouldn't "--verbose" be accepted as a long version of the option? That
would mean adding it to long_options.

The usage message cmd_device_scan_usage needs to be updated to include
the new option(s).

I have tested this on my systems (4.19 kernel) and it not only works
well, it is useful to get the list of devices it finds. If you wish,
feel free to add:

Tested-by: Graham Cobb <g.btrfs@cobb.uk.net>

Graham

>> diff --git a/cmds/filesystem.c b/cmds/filesystem.c
>> index 4f22089abeaa..02d47a43a792 100644
>> --- a/cmds/filesystem.c
>> +++ b/cmds/filesystem.c
>> @@ -746,7 +746,7 @@ devs_only:
>>           else
>>               ret = 1;
>>       } else {
>> -        ret = btrfs_scan_devices();
>> +        ret = btrfs_scan_devices(false);
>>       }
>>         if (ret) {
>> diff --git a/common/device-scan.c b/common/device-scan.c
>> index 48dbd9e19715..a500edf0f7d7 100644
>> --- a/common/device-scan.c
>> +++ b/common/device-scan.c
>> @@ -360,7 +360,7 @@ void free_seen_fsid(struct seen_fsid
>> *seen_fsid_hash[])
>>       }
>>   }
>>   -int btrfs_scan_devices(void)
>> +int btrfs_scan_devices(bool verbose)
>>   {
>>       int fd = -1;
>>       int ret;
>> @@ -389,6 +389,8 @@ int btrfs_scan_devices(void)
>>               continue;
>>           /* if we are here its definitely a btrfs disk*/
>>           strncpy_null(path, blkid_dev_devname(dev));
>> +        if (verbose)
>> +            printf("blkid: btrfs device: %s\n", path);
>>             fd = open(path, O_RDONLY);
>>           if (fd < 0) {
>> diff --git a/common/device-scan.h b/common/device-scan.h
>> index eda2bae5c6c4..3e473c48d1af 100644
>> --- a/common/device-scan.h
>> +++ b/common/device-scan.h
>> @@ -1,6 +1,7 @@
>>   #ifndef __DEVICE_SCAN_H__
>>   #define __DEVICE_SCAN_H__
>>   +#include <stdbool.h>
>>   #include "kerncompat.h"
>>   #include "ioctl.h"
>>   @@ -29,7 +30,7 @@ struct seen_fsid {
>>       int fd;
>>   };
>>   -int btrfs_scan_devices(void);
>> +int btrfs_scan_devices(bool verbose);
>>   int btrfs_register_one_device(const char *fname);
>>   int btrfs_register_all_devices(void);
>>   int btrfs_add_to_fsid(struct btrfs_trans_handle *trans,
>> diff --git a/common/utils.c b/common/utils.c
>> index f2a10cccca86..9a02a80492cb 100644
>> --- a/common/utils.c
>> +++ b/common/utils.c
>> @@ -277,7 +277,7 @@ int check_mounted_where(int fd, const char *file,
>> char *where, int size,
>>         /* scan other devices */
>>       if (is_btrfs && total_devs > 1) {
>> -        ret = btrfs_scan_devices();
>> +        ret = btrfs_scan_devices(false);
>>           if (ret)
>>               return ret;
>>       }
>> diff --git a/disk-io.c b/disk-io.c
>> index 01314504a50a..d5b3e4f793e4 100644
>> --- a/disk-io.c
>> +++ b/disk-io.c
>> @@ -1085,7 +1085,7 @@ int btrfs_scan_fs_devices(int fd, const char *path,
>>       }
>>         if (!skip_devices && total_devs != 1) {
>> -        ret = btrfs_scan_devices();
>> +        ret = btrfs_scan_devices(false);
>>           if (ret)
>>               return ret;
>>       }
>>
> 

