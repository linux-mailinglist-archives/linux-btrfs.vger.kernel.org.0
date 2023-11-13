Return-Path: <linux-btrfs+bounces-92-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F153A7E9DC9
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Nov 2023 14:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C99D1C2095C
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Nov 2023 13:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57BB208B9;
	Mon, 13 Nov 2023 13:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TlhKu8oL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520FC1D555
	for <linux-btrfs@vger.kernel.org>; Mon, 13 Nov 2023 13:50:05 +0000 (UTC)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC8FD51;
	Mon, 13 Nov 2023 05:50:02 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1ce28faa92dso6600285ad.2;
        Mon, 13 Nov 2023 05:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699883402; x=1700488202; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wq1ZKUe+uh1WKjH1+/+KfdiLv4QqjB0cEeGloNzb1j4=;
        b=TlhKu8oLds/yd4lVa0tDPeaOil4NcUitjNt4HNyW+jzbuhy4UnDBtGs2/iIYC8HWXn
         2k9HrHhebQrRzVI063lvcyqoXi9fXypvuA8SW4IXTC1YGmE06ksryHB8Xg/7lxXX1oPb
         ChbQY5XnWdBAJK0etgDmphbsoQ6uhCl/20dQxa0ACR2t0TszHg4wboW2SC6vVpuzum1P
         ijkL0wpblHTl/5Gv0ApMCaUWrJR5IdTv858RGzcZvV0/2UJkD2nxoGZicWjMuyAeJy7w
         gemk4nyR5SDDsQsj487HkbXeOdXlqZrTHQmBsK2PAExvqhrc1cT9YxGhiNhZYpCcWa7U
         K2+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699883402; x=1700488202;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wq1ZKUe+uh1WKjH1+/+KfdiLv4QqjB0cEeGloNzb1j4=;
        b=Q828J9Ct0H6K7o7dyNOgbyB4NG05mPAMDI0SsWoiDp3Zv9M10Raj7Nb5IoDZQ/zF5m
         s1w0fHWZc9oRQXis4x94O4CWFk6utFEgtRLQAzW49OuxjjgZC6VEjKrQf3MfvHLIO+9E
         nCY6x6uFvrR/tCfC3PXA4P/Fi9/Cb22cOLzwh2j5KzITDaF01zv+v6ohvM2Y67C2aXEx
         IZq2DQZLv+atf4XjQCozhiiQPpU1aVy5UIgdzTLcwzKp53l2WB/HNn3Anoowq6aHQb4d
         L0GlZARIKSGBLE3fINkhMZ0Rr4nc9PzJJUf/JEJsc1G7NAHe44ys6rQYPDFYS8LvbgZY
         Djow==
X-Gm-Message-State: AOJu0YwQ8XgX2Mv0IzL9By31gPDu7IsjF4h5gUShk+Dxr60Kv7ySI0fM
	iNPX3fIPS18a5UUAYtAjqVc=
X-Google-Smtp-Source: AGHT+IFVRvJD43TJoJFx4UXsa/Q3y7he0LvUsV3N4WxhaRuq0fuQaU7+eJ9zAKCvTNgA74gdYjsw7w==
X-Received: by 2002:a17:903:41c8:b0:1cc:6a09:a489 with SMTP id u8-20020a17090341c800b001cc6a09a489mr5500583ple.33.1699883401716;
        Mon, 13 Nov 2023 05:50:01 -0800 (PST)
Received: from [192.168.1.6] ([59.182.194.4])
        by smtp.gmail.com with ESMTPSA id l18-20020a170903245200b001b9be3b94d3sm4040860pls.140.2023.11.13.05.49.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Nov 2023 05:50:00 -0800 (PST)
Message-ID: <a76a57f8-aad8-46e2-bcc2-acfa35752352@gmail.com>
Date: Mon, 13 Nov 2023 19:19:56 +0530
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: ref-verify: fix memory leaks
To: Filipe Manana <fdmanana@kernel.org>
Cc: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
 linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+d66de4cbf532749df35f@syzkaller.appspotmail.com
References: <20231112165648.10537-1-bragathemanick0908@gmail.com>
 <CAL3q7H72WXSSS-crLCGi=07x8F58j9k7B9Udk8k2MVwgptO27g@mail.gmail.com>
Content-Language: en-US
From: Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
In-Reply-To: <CAL3q7H72WXSSS-crLCGi=07x8F58j9k7B9Udk8k2MVwgptO27g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 13/11/23 18:50, Filipe Manana wrote:
> On Sun, Nov 12, 2023 at 4:57 PM Bragatheswaran Manickavel
> <bragathemanick0908@gmail.com> wrote:
>> In btrfs_ref_tree_mod(), when !parent 're' was allocated
>> through kmalloc(). In the following code, if an error occurs,
>> the execution will be redirected to 'out' or 'out_unlock' and
>> the function will be exited. However, on some of the paths,
>> 're' are not deallocated and may lead to memory leaks.
>>
>> For example : lookup_block_entry() for 'be' returns null, the
>> out label will be invoked. During that flow ref and ra was
>> freed but not re, which can potentially lead to memleak
>>
>> Reported-and-tested-by: syzbot+d66de4cbf532749df35f@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?extid=d66de4cbf532749df35f
>> Signed-off-by: Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
>> ---
>>   fs/btrfs/ref-verify.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/fs/btrfs/ref-verify.c b/fs/btrfs/ref-verify.c
>> index 95d28497de7c..50b59b3dc474 100644
>> --- a/fs/btrfs/ref-verify.c
>> +++ b/fs/btrfs/ref-verify.c
>> @@ -791,6 +791,7 @@ int btrfs_ref_tree_mod(struct btrfs_fs_info *fs_info,
>>                          dump_ref_action(fs_info, ra);
>>                          kfree(ref);
>>                          kfree(ra);
>> +                       kfree(re);
> Here it's fine, 're' was not yet added to the rbtree (be->roots).
>
>>                          goto out_unlock;
>>                  } else if (be->num_refs == 0) {
>>                          btrfs_err(fs_info,
>> @@ -800,6 +801,7 @@ int btrfs_ref_tree_mod(struct btrfs_fs_info *fs_info,
>>                          dump_ref_action(fs_info, ra);
>>                          kfree(ref);
>>                          kfree(ra);
>> +                       kfree(re);
> Same here.
>
>>                          goto out_unlock;
>>                  }
>>
>> @@ -822,6 +824,7 @@ int btrfs_ref_tree_mod(struct btrfs_fs_info *fs_info,
>>                                  dump_ref_action(fs_info, ra);
>>                                  kfree(ref);
>>                                  kfree(ra);
>> +                               kfree(re);
> Here it's not ok. 're' was added to the rbtree, so you can't free it,
> as later when accessing the tree, it will trigger a use-after-free
> bug.
>
>>                                  goto out_unlock;
>>                          }
>>                          exist->num_refs--;
>> @@ -838,6 +841,7 @@ int btrfs_ref_tree_mod(struct btrfs_fs_info *fs_info,
>>                          dump_ref_action(fs_info, ra);
>>                          kfree(ref);
>>                          kfree(ra);
>> +                       kfree(re);
> Same here, it will lead to a use-after-free.
>
>>                          goto out_unlock;
>>                  }
>>                  kfree(ref);
>> @@ -849,6 +853,7 @@ int btrfs_ref_tree_mod(struct btrfs_fs_info *fs_info,
>>                          dump_ref_action(fs_info, ra);
>>                          kfree(ref);
>>                          kfree(ra);
>> +                       kfree(re);
> Same here, it will lead to a use-after-free.
>
> Thanks.
>>                          goto out_unlock;
>>                  }
>>          }
>> --
>> 2.34.1

Thanks Filipe for reviewing this!

Now, I understood why we shouldn't free 're' after it was added to the 
tree.
In that case, can I send a new patch with first two changes.


