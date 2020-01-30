Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63C5514E4FC
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jan 2020 22:42:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbgA3Vm3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Jan 2020 16:42:29 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:37709 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbgA3Vm3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Jan 2020 16:42:29 -0500
Received: by mail-qk1-f195.google.com with SMTP id 21so4551356qky.4
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Jan 2020 13:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=viTbQxc4CCacbri/y1R4c7uGFeDm/QDu4RHTTN4yBJU=;
        b=ZLECueyOj+byGU8MCz1Io4BlT8aSWnYM4TCuOoZVz3VXnQ+rox0c36fzgFmSh2QJfE
         8fShl2wF+RCYJXDJjcpjPHxMHt/M/EKJqYjLO2aKZ5i5loc0FsyOLKHTX+URxPhFtRj2
         gndRxc10VBcu5+JoVlqmJgLKObwHvxuX3v46dpaI+VCsvdO+X7Z9m82vdhzb1UX08Nx7
         xl6l/5S30yeZbCm9i9Ky2eQWD6hX+4cOX+eSoAiyybSva+2VK6h+wvkjUEqRd+89i/EB
         ODMggrNgOLOsFrd8Juf1a6SbDh4Zb5QlpYn37aCLNyacNTvyJZMKNZ0/U9fKfECddcJV
         2ORw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=viTbQxc4CCacbri/y1R4c7uGFeDm/QDu4RHTTN4yBJU=;
        b=hO8Lc1DWEpCvhs8/zkKiPXSLi+q4ts7fa07+n+X+Tb0Oz3CkM2b3VanjW89Ha6bz51
         u373ZyKB/zlvUaa/a5uF07W2P0mkqPHy0hvuQhrAoOQVX4stIqzWCHEKDqMTXUj5bA6p
         aLdTQJ6xm9tLsE+h7slb9I9BXxMU0fihTuRjF4gA19yknoir1zJQ81SRitmB48s3VU7F
         9xK6nIaELXmIuaP4QEhHiPNy60ckeqYDeuX4JQ4cENpBJ7Rvx/xuH3bHrSm0bC9Xknbz
         EuebNd1l9Waj2Fg1f1GpiAMtMaKSHToCLMn3/LdkrbVHPNbDdFORvJxFlt3VdI25E7E1
         BTQg==
X-Gm-Message-State: APjAAAXeaPxiYoBaVr7H+/0vWazmmoK0qoG8ac44QZtKVkxWzu6FsdSw
        SCMVGRt067aI27p9+WxKsoXPWzdODxjXjQ==
X-Google-Smtp-Source: APXvYqw8ub8u9eOzwM31nGnbrCKwNnFruPG/YOyC6KzR2r81XGeoREKeBlWbOshMEZDEmja9hLyAzw==
X-Received: by 2002:a05:620a:16bb:: with SMTP id s27mr7880159qkj.368.1580420547588;
        Thu, 30 Jan 2020 13:42:27 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::981a])
        by smtp.gmail.com with ESMTPSA id 4sm3464311qkv.44.2020.01.30.13.42.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jan 2020 13:42:26 -0800 (PST)
Subject: Re: With Linux 5.5: Filesystem full while still 90 GiB free
To:     Martin Raiber <martin@urbackup.org>,
        Chris Murphy <lists@colorremedies.com>
Cc:     Martin Steigerwald <martin@lichtvoll.de>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <112911984.cFFYNXyRg4@merkaba> <10361507.xcyXs1b6NT@merkaba>
 <CAJCQCtQgqg2u78q2vZi=bEy+bkzX48M+vHXR00dsuNYWaxqRKg@mail.gmail.com>
 <21104414.nfYVoVUMY0@merkaba>
 <CAJCQCtSgK1f3eG5XzaHmV+_xAgPFhAGvnyxuUOmGRMCZfKaErw@mail.gmail.com>
 <ab7f3087-7774-7660-1390-ba0d8e6d7010@toxicpanda.com>
 <CAJCQCtRq5Q25sqW8wrfiYecnMg3Q+XjTuChdCU=cg9AwboVtCQ@mail.gmail.com>
 <0102016ff85ee439-d6f9d7e0-c71e-426e-bade-318dcc91b660-000000@eu-west-1.amazonses.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <70a944b5-9609-8014-547a-89a8279b708a@toxicpanda.com>
Date:   Thu, 30 Jan 2020 16:42:26 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <0102016ff85ee439-d6f9d7e0-c71e-426e-bade-318dcc91b660-000000@eu-west-1.amazonses.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/30/20 4:32 PM, Martin Raiber wrote:
> On 30.01.2020 22:09 Chris Murphy wrote:
>> On Thu, Jan 30, 2020 at 1:59 PM Josef Bacik <josef@toxicpanda.com> wrote:
>>> The file system is fine, you don't need to balance or anything, this is purely a
>>> cosmetic bug.
>> It's not entirely cosmetic if a program uses statfs to check free
>> space and then errors when it finds none. Some people are running into
>> that.
>>
>> https://lore.kernel.org/linux-btrfs/alpine.DEB.2.21.99999.375.2001131514010.21037@trent.utfs.org/
>>
>> I guess right now the most reliable work around is to revert to 5.3.18.
> 
> Yeah, my backup system does check via statfs() if a file fits on storage
> before backing it up and there is also a setting (global soft file
> system quota) that allows users to configure the amount of storage the
> backup system should use (e.g. 90% of available storage). In both cases
> with statfs() returning zero it'll delete backups till there is "enough
> free space", i.e. it'll delete all the backups it is allowed to delete
> and then start reporting errors, which is obviously very problematic.
> 

Yup I'm not meaning to say your application causing you problems isn't real ;). 
But balancing and such or using metadata_ratio isn't necessary, we just need to 
fix statfs for you so the application stops misbehaving.  Thanks,

Josef
