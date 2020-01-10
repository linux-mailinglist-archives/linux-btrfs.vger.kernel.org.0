Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 872AA13723E
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jan 2020 17:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728543AbgAJQFG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Jan 2020 11:05:06 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45560 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728480AbgAJQFG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Jan 2020 11:05:06 -0500
Received: by mail-qt1-f194.google.com with SMTP id w30so2290001qtd.12
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Jan 2020 08:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=0BP9kMKZivIE9MvHi9mfsx6lRcZfcFOJg21AUeF+8wU=;
        b=tLGDoJTl2Ct9m/2C2Z4Lu4xfsa77sYtXRkCa+o6WMrJOTrXhdPcqXu8x/WjJg/CR76
         GxWh3BNii/OaORpnCetDDcLfbuLogGfV/jc3guiOYwMbD/Hl6iGE46O5EP+POvtPb5rs
         RB20YbkW0Kux1v6kEttw8KoAAtYmWxG4A2RVMWcxzXD6MtmWYxUi6SCDeljPQObZCX+o
         DBrp0+E00sKrLkh4Bdq9kH3LVMJ1oBVBNh96vBjneYPiJhgEq2LPBxgqOICckCoXhVmw
         HJqW3S1H9gS4RcrP62ZJz2m/pYmwCuH1um1SoygzmwJ/Pr/gFk7NYWUkde6EPsN9SqAQ
         e4Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0BP9kMKZivIE9MvHi9mfsx6lRcZfcFOJg21AUeF+8wU=;
        b=Arl6ZIvPi6UdsZzJfMfxTtNKEqVF02sHSSBMQnwNDppxYsuedHhaSLyCzE+v5Qk+vb
         g69FRwPZguqUwQ7qWdlELCtRZ2tEQmryKNJX+t7zSS2lTRKaSIZBNVIZGETzfLMm+6pt
         CLRF8D1OWkIEJWm/sZP9yRAlPqSFuHbkwAEVhdfZ7JY/MUPknnjXT2/K2r28OJeKrecr
         rkt3CcAHsCffF1DamcKrXDFh2kU0sBaK3lGBkpn9kZe84W8ww+2acQw8xKUtp0RNzrkL
         V4JGHgbf+dUroFZk+M9XSiIxDfPoZYk10eFF0+e3vU1sFv9SVlElOIaUe2Z7G2jGKbTH
         DogQ==
X-Gm-Message-State: APjAAAVHRQH++V88P1/oYK0HvhfYp5hL/9EhcAPAXWBrUUniU4TFF6wQ
        UbbXegwMll2mq3mXccXe5OHPww==
X-Google-Smtp-Source: APXvYqwMslhhTmRYLU5fVwJSI1CvTHnqQAlaDCIsykHP7uZKPiDDpZE7uPNezyc/Qah7PGg1dhj9ug==
X-Received: by 2002:ac8:4a10:: with SMTP id x16mr2928251qtq.371.1578672304515;
        Fri, 10 Jan 2020 08:05:04 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::4dc2])
        by smtp.gmail.com with ESMTPSA id i16sm1028424qkh.120.2020.01.10.08.05.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2020 08:05:03 -0800 (PST)
Subject: Re: [PATCH 0/4][v2] clean up how we mark block groups read only
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, dsterba@suse.cz,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com, wqu@suse.com
References: <20191126162556.150483-1-josef@toxicpanda.com>
 <20191203195139.GC2734@twin.jikos.cz>
 <d4838402-3acd-1fea-6d61-7ff806629e1a@gmx.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <6b69f555-1881-d560-18b4-5a8892007e73@toxicpanda.com>
Date:   Fri, 10 Jan 2020 11:05:02 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <d4838402-3acd-1fea-6d61-7ff806629e1a@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/9/20 11:35 PM, Qu Wenruo wrote:
> 
> 
> On 2019/12/4 上午3:51, David Sterba wrote:
>> On Tue, Nov 26, 2019 at 11:25:52AM -0500, Josef Bacik wrote:
>>> v1->v2:
>>> - Fixed the typo where I wasn't checking against total_bytes.
>>> - Added the force check to the read only list addition check at the top.
>>> - Fixed the comment stating that sinfo_used + num_bytes should be <=
>>>    total_bytes, that's not the case at all.
>>> - Added the various reviewed-by's.
>>
>> I'm applying 1 and 2 to misc-next, 3 and 4 once the comments are
>> addressed.
>>
> Hi Josef,
> 
> Would you mind to update the patchset?
> 
> If you're busy I could keep your author and do the misc work of patch 3/4.
> 

I'm not sure what needs to be done with 3 and 4, the commit you reference isn't 
in my tree, and in fact that !do_chunk_alloc part doesn't even exist anymore.  I 
can resend the updated patches I guess, but it doesn't appear I need to do 
anything?  Thanks,

Josef
