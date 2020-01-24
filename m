Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD61D1487E1
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jan 2020 15:26:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388072AbgAXOZW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Jan 2020 09:25:22 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:38371 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387569AbgAXOZV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Jan 2020 09:25:21 -0500
Received: by mail-qt1-f194.google.com with SMTP id c24so1612804qtp.5
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Jan 2020 06:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=2ib0thfqgyAmjI0xZS97hVZ+gXNa4KsNpp0Ri152l6M=;
        b=aRaW2HBP9su2njgCIK3zpWlxTKqp+nSepKRtAjTPMZVooQ7ihiAaZ5PYooBsR+CORB
         t3tEwTXWfpOZZKkBGm4vl5gh1+V1BlWVykGv+TdCZSeItsb7KqTN7k2qbVxd+pdslAZR
         VLaQBlagUAIKZlO7+eWNLKimGseF0OHOcOo+IIoVq/qGsp8GqVt5ky/h87k4OoBAPc60
         /UI2qZcHkeiLxUOZmrs45xen5lD9l6X7VkOv1a6zBC22P8antKbFqByTXWRBuQ1qrKnb
         Be9KxS3sWUCtNdfk+RXdrOrD9vFWRjaNMsrOVVPUPJpDmRgcbNZkVaf96v0rh0Pcq9ph
         PRKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2ib0thfqgyAmjI0xZS97hVZ+gXNa4KsNpp0Ri152l6M=;
        b=sNWe0jqFvnDuTpY4WOJVVNJhtQX7BxgHQ40t2QzeHxCHA5T7IWAP5i+6zIgz1wFOxe
         yeygUmdy8LeLXmDXwZELhg2gsRondNfYN00t168tf8du6kjBdQWUkzZruFnCeLxL9YQT
         TSUYp0PbzUalhUusNFoppCnJQaMYBNEU2BxImpXFXmKZdMUHdXrAtQxsO6lhBg2714wS
         7ljYaiT7Rt6Gb0HvTw0Ng02m16xTJvIdoF/hu9myihJ6pZGjomA9clM0xbNGDQjts+BF
         dDmyf/cTwjAMIw6+BU//xjn6moPd6YVHiRyEbLlcMV5qeQzin7FCol1O3wo35bsN6JdR
         t/kw==
X-Gm-Message-State: APjAAAXwljSdhC9T0Z3i+tyGynNt0VANGmQCyxou2wOMy+4cc0nvsXNd
        UB1AEll82Lgap5NOnUWp9gKgBw==
X-Google-Smtp-Source: APXvYqyupTaUkF5diqrwzP0kEamNF+WGV+d8y9hIWaJt+xCX2sYStmO6dMPC5wdKJUbucalJqWV+fA==
X-Received: by 2002:ac8:32ec:: with SMTP id a41mr2355522qtb.235.1579875919843;
        Fri, 24 Jan 2020 06:25:19 -0800 (PST)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id u24sm3164229qkm.40.2020.01.24.06.25.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jan 2020 06:25:18 -0800 (PST)
Subject: Re: [PATCH 41/43] btrfs: make the init of static elements in fs_info
 separate
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <20200117212602.6737-1-josef@toxicpanda.com>
 <20200117212602.6737-42-josef@toxicpanda.com>
 <987b7059-0bc8-b4ad-0898-5c50c6ac762b@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <87255610-23b2-ac0e-03be-426ee28d70fb@toxicpanda.com>
Date:   Fri, 24 Jan 2020 09:25:18 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <987b7059-0bc8-b4ad-0898-5c50c6ac762b@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/23/20 7:30 AM, Nikolay Borisov wrote:
> 
> 
> On 17.01.20 г. 23:26 ч., Josef Bacik wrote:
>> In adding things like eb leak checking and root leak checking there were
>> a lot of weird corner cases that come from the fact that
>>
>> 1) We do not init the fs_info until we get to open_ctree time in the
>> normal case and
>>
>> 2) The test infrastructure half-init's the fs_info for things that it
>> needs.
>>
>> This makes it really annoying to make changes because you have to add
>> init in two different places, have special cases for testing fs_info's
>> that may not have certain things init'ed, and cases for fs_info's that
>> didn't make it to open_ctree and thus are not fully init'ed.
>>
>> Fix this by extracting out the non-allocating init of the fs info into
>> it's own public function and use that to make sure we're all getting
>> consistent views of an allocated fs_info.
>>
> 
> 
> Imo it will be better if btrfs_init_fs_info is called from
> init_mount_fs_info. And then called explicitly from the test code. That
> way we keep the initialization close. Otherwise having it in
> btrfs_mount_root is just confusing and not very obvious what's going on.
> 

I'm not sure what's confusing about it, we're allocating the structure and then 
initializing it.  And as I point out in the changelog, this is necessary because 
the error handling is bonkers because we can fail at multiple places _before_ 
open_ctree, and having random garbage in the fs_info makes proper cleanup a 
pain.  Thus it _has_ to be exported and the fs_info _has_ to have it's static 
elements properly initialized in order to make cleanup in the error cases clean 
and sane.  Thanks,

Josef
