Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5C9715CBC4
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Feb 2020 21:13:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbgBMUNT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Feb 2020 15:13:19 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40446 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727799AbgBMUNT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Feb 2020 15:13:19 -0500
Received: by mail-pl1-f196.google.com with SMTP id y1so2772977plp.7
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Feb 2020 12:13:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=HTPuGoRL7s8TK+5GFC+URKmjvApgZ/DW6Dch2q0cAB4=;
        b=fu+ug4hHvyYl/XFH46VTyeywLaxdnfP6iz0ubZWxWi51YbhuhmqhSeUm6nsfkKbw/k
         AaHPtR7yMQqcxVTKc5gghoS0WKLGxPowKtrLkd80PNomGQBmjI6GLNONdSf1+NWyQHO6
         PwHpO3jldrosjqNpl4zvEh5A+Y1zfTyqjUZirL9tDDoZ7pAxtfhfIDO66r9lYS0edzHW
         YyK4t63rNdAZ4lgoGf6mD7iw7IMVAiqJdkg55Wl+qV6EVepyUfsBsmAEFW5yuHK4wYFC
         CR1S2ZSxYzFkNF94dNtvyF6HXMzTNPFTi/bdQrmT18EBah22kq7LpIrVWhIXRENisnNW
         ViCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HTPuGoRL7s8TK+5GFC+URKmjvApgZ/DW6Dch2q0cAB4=;
        b=uQ+A4tPvmJu7DhWTXAjwKhh+IqwIt4SZULSQebr6ODndMfSPbilrqu7B4VBRDZArq8
         UtlqJfewlRQ9iATzKE+Nn4w1M/khgXEaidBjlckPif3p7WwRfjI7O3XA/CqlGmlRqPCm
         wjx1KhZdN3SuUImEzc2ZBEKp9gJOJU8MhmCgIAnDpkGhhzKNNXf9wMnjr8a6EZgLEzzm
         5DK2xBxYzZYevbddi+6oNbISX72jL2YfO0frvWQIDFEe817IyS5DJjWdgrNFzySKX6/p
         cTOQok936s16rlSCkpru4of6Tx9B5q2iosuPN4dOuRq5xdbvlSEtKmjYTWrTzXLBiokT
         HhyQ==
X-Gm-Message-State: APjAAAUf3sY+FE8Xa7BcawMgO7dZo+Co53Y17nPrSAArnWf9fqmdAdDN
        RtyF/iVKAgvGlEAXIjKssKSxcB7KliQ=
X-Google-Smtp-Source: APXvYqxvyFQ8yI9lblPA5OOKfblxOPmD1CEHGSIRn/YCx2j+5OjDd8zQbLuaXT5v4SFgIFRyeUa4KQ==
X-Received: by 2002:a17:902:6b03:: with SMTP id o3mr14624199plk.331.1581624797189;
        Thu, 13 Feb 2020 12:13:17 -0800 (PST)
Received: from ?IPv6:2620:10d:c085:21cf::1150? ([2620:10d:c090:400::5:249c])
        by smtp.gmail.com with ESMTPSA id b10sm3566072pjo.32.2020.02.13.12.13.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2020 12:13:16 -0800 (PST)
Subject: Re: [PATCH] Btrfs: fix btrfs_wait_ordered_range() so that it waits
 for all ordered extents
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <20200213122950.12115-1-fdmanana@kernel.org>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <8a160af7-1ef6-22b5-af37-41fa5c0cc225@toxicpanda.com>
Date:   Thu, 13 Feb 2020 15:13:14 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200213122950.12115-1-fdmanana@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/13/20 7:29 AM, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> In btrfs_wait_ordered_range() once we find an ordered extent that has
> finished with an error we exit the loop and don't wait for any other
> ordered extents that might be still in progress.
> 
> All the users of btrfs_wait_ordered_range() expect that there are no more
> ordered extents in progress after that function returns. So past fixes
> such like the ones from the two following commits:
> 
>    ff612ba7849964 ("btrfs: fix panic during relocation after ENOSPC before
>                     writeback happens")
> 
>    28aeeac1dd3080 ("Btrfs: fix panic when starting bg cache writeout after
>                     IO error")
> 
> don't work when there are multiple ordered extents in the range.
> 
> Fix that by making btrfs_wait_ordered_range() wait for all ordered extents
> even after it finds one that had an error.
> 
> Link: https://github.com/kdave/btrfs-progs/issues/228#issuecomment-569777554
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Man that subject made things sounds a lot worse than it actually was,

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
