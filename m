Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F216213E002
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Jan 2020 17:25:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbgAPQZD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Jan 2020 11:25:03 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:44617 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbgAPQZD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Jan 2020 11:25:03 -0500
Received: by mail-qk1-f194.google.com with SMTP id w127so19607568qkb.11
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Jan 2020 08:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=LS0YI5HfhZG5w7+tbbe627krL3pNZVomrbo36BvWYK0=;
        b=mAIhKFRbZ8R/hAVM6okor565uGCeUtsrVP5LPLquncEHY2XJGLj7siLI4sJRdO3fdA
         W5KRFoJ2dE7pax+oT+yCeANE2mv6KiLRih6b/m+Vatu12KVfMBJkjICQsjZXZaXKxZ9y
         h8I46h8U0ZPpaLW6IMuLFysOUFZe+UT/6qb0udny7pbVUo8BEizI69jFf9DVBFJbcZz6
         D4J1nGd3vzqGFPN7lh1MpLcGkyO9Uie9Lyr34AvaHS0YgGSi4uZJVP40lUYuyGbWEFat
         26rw5Mf30OEbLtpMBuCjPWFiSFbBkQQtopE1f53FFMT1TmiRDX7wwPyUwL75QvZfmmok
         s9Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LS0YI5HfhZG5w7+tbbe627krL3pNZVomrbo36BvWYK0=;
        b=E1EFsZbS/rUmPbFDRaOARYJtR+R2xCaCyJ8IoZ/qj6w0ym51dMJBjmDGnIOihwf1ML
         tfGeVjqgW54UINoUAKPdufYyakvEeYISoO+9Oy9CVHd82Vap6FwK1gAbku0+GVh4/g0h
         9igyo3Zf6/XdJwri+hloK9WuHhMRU+cwUcX3Buy4BvPpzhsg0wLOlMhl3n7aXUiZDxbb
         /j0KiHwfsAUre4syiH7JhneqTIU3SJhfB9ueUJAbIJJS1/9joUQVnske2j2fGi09fPyp
         sWrNU49E9LukHpZoi/0RsiRzFzpJpBnVrAm8kqW9aGmW2Fij+FkjPZDnayP/urmRNlKQ
         yutQ==
X-Gm-Message-State: APjAAAWcFhPTNLU/h6qmRSv9qAu8AHd83N8ztOZf6/sVOVla9AsYxYoa
        9VP/0RUrBiVtucUUzxLrMacFFQ==
X-Google-Smtp-Source: APXvYqyItzGULzjZ565pjua+OFRI+oRQ0VfzDN4gBy1TuIWYtFpf+4l8/6LjxcUeFGBkPmi2KTmcJQ==
X-Received: by 2002:a37:a54b:: with SMTP id o72mr28713032qke.313.1579191902122;
        Thu, 16 Jan 2020 08:25:02 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::6813])
        by smtp.gmail.com with ESMTPSA id s11sm10331295qkg.99.2020.01.16.08.25.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2020 08:25:01 -0800 (PST)
Subject: Re: [PATCH 1/5] btrfs: check rw_devices, not num_devices for
 restriping
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20200110161128.21710-1-josef@toxicpanda.com>
 <20200110161128.21710-2-josef@toxicpanda.com>
 <20200114205609.GL3929@twin.jikos.cz>
 <801709ca-22cd-f6ed-4e39-622a6aa1a1e6@toxicpanda.com>
 <20200116155955.GY3929@twin.jikos.cz>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <fe1af903-631c-5a4a-d67c-eece281a6def@toxicpanda.com>
Date:   Thu, 16 Jan 2020 11:25:00 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200116155955.GY3929@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/16/20 10:59 AM, David Sterba wrote:
> On Tue, Jan 14, 2020 at 01:07:22PM -0800, Josef Bacik wrote:
>>>> -	num_devices = btrfs_num_devices(fs_info);
>>>> +	/*
>>>> +	 * rw_devices can be messed with by rm_device and device replace, so
>>>> +	 * take the chunk_mutex to make sure we have a relatively consistent
>>>> +	 * view of the fs at this point.
>>>
>>> Well, what does 'relatively consistent' mean here? There are enough
>>> locks and exclusion that device remove or replace should not change the
>>> value until btrfs_balance ends, no?
>>>
>>
>> Again I don't have the code in front of me, but there's nothing at this point to
>> stop us from running in at the tail end of device replace or device rm.
> 
> This should be prevented by the EXCL_OP mechanism, so even the end of
> device remove or replace will not be running at this time because it
> cannot even start.
> 
>> The
>> mutex keeps us from getting weirdly inflated values when we increment and
>> decrement at the end of device replace, but there's nothing (that I can
>> remember) that will stop rw devices from changing right after we check it, thus
>> relatively.
> 
> rw_devices is changed in a handful of places on a mounted filesystem,
> not counting device open/close. Device remove and replace are excluded
> from running at that time, rw_devices can't change at this point of
> balance.
> 
> btrfs_dev_replace_finishing
>   - when removing srcdev, rw_devices--
>   - when adding the target device as new, rw_devices++
> 
> btrfs_rm_device
>   - rw_devices--
> 
> btrfs_init_new_device (called by device add)
>   - rw_devices++
> 
> So the chunk mutex is either redundant or there's something I'm missing.
> 

Nope you're right, I missed the EXCL_OP thing, so we can just read rw_devices 
normally.  Thanks,

Josef
