Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE3614F70D
	for <lists+linux-btrfs@lfdr.de>; Sat,  1 Feb 2020 08:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbgBAHg5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 1 Feb 2020 02:36:57 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45649 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbgBAHg5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 1 Feb 2020 02:36:57 -0500
Received: by mail-pf1-f195.google.com with SMTP id 2so4633456pfg.12;
        Fri, 31 Jan 2020 23:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=I+jRZq2XIwvW7oIRq1PIrb+5cf/HFrnPVa/ZNKQ7FnM=;
        b=IdwfpzjjXg4u72pCz/u53g809RdGXsEue3Njlu4pmiUgIdSLqcNPjCI1O3LG2uy/Vk
         4obs4V2Z7DSfPcJfY/MHL22mNhOPTmvF/VsfHFGHszO1pmRvVzYrQTW9NRbuFf6y1piy
         63A9GaxchzSOu/yO7Qvdg855im39WscWf94bl7v8ox4SQa6xsg3uYpXEbaFzA5z2xfzf
         xX5X+Mv20n+rZ7uAV0tiZF/QIVxBuO4WzV/73w6wKdBsXuoUkA6RkPAN/Pw3ZxNw14c4
         NwEDngrusme9Kb7r18wm/gRrflTXWiRtp+pMopG4A+5cUB19g+53fY9BOxiErLNxHHHE
         U6ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=I+jRZq2XIwvW7oIRq1PIrb+5cf/HFrnPVa/ZNKQ7FnM=;
        b=tXdo4Nhk2OUHfkQw+cA66S9BXc9LqHTkgc8wNqeBbGRw4z4kO8Gk98ZxVQva2HTZGR
         ifwzi6LXNPSSEynzNtSfTar5ON6bP4AwdZRag+OyIAg6SXkRaSgKSyMrJ/7i0Dmutv0p
         klQhcbS8sFsgdRJks+58+5XFnfJSegK45bt6e1HVQQo/rrUHugGsxeutrX2ycuxVjfQ4
         90X11dFx/HGgjfYBH3nI8Sgi/ijIiBZDb3SfccLgIhzpDjniA0KZScLIKBZv7Rp0KaXK
         +cUlufMQ4x5FslfC9sRzQ8ei3solbMUEYGubLLcc4hnfJG/ct5wjiQ0pcvZwbIZ5BMOr
         OA8g==
X-Gm-Message-State: APjAAAXpCs4fKrNG04Hd7x2r7C2tcKkf2PPtym2j+WZNRaX+owBzAPZa
        Nf9teK1CwDnjropAa0LNt8M=
X-Google-Smtp-Source: APXvYqyu+igt0+W1CIhy68Has71RnjbyboRXfSRcVadRamIIaXEZybiEh8s79z5ajjCZjvn0fr5oAQ==
X-Received: by 2002:aa7:91c1:: with SMTP id z1mr15188554pfa.182.1580542616651;
        Fri, 31 Jan 2020 23:36:56 -0800 (PST)
Received: from localhost ([178.128.102.47])
        by smtp.gmail.com with ESMTPSA id s124sm13343485pfc.57.2020.01.31.23.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2020 23:36:55 -0800 (PST)
Date:   Sat, 1 Feb 2020 15:36:49 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] fstests: btrfs/153: Remove it from auto group
Message-ID: <20200201073649.GA2697@desktop>
References: <20200114125044.21594-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200114125044.21594-1-wqu@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jan 14, 2020 at 08:50:44PM +0800, Qu Wenruo wrote:
> This test case always fail after commit c6887cd11149 ("Btrfs: don't do
> nocow check unless we have to").
> As btrfs no longer checks nodatacow at buffered write time.
> 
> That commits brings in a big performance enhancement, as that check is
> not cheap, but breaks qgroup, as write into preallocated space now needs
> extra space.
> 
> There isn't yet a good solution (reverting that patch is not possible,
> and only check nodatacow for quota enabled case is very bug prune due to
> quite a lot code change).
> 
> We may solve it using the new ticketed space reservation facility, but
> that won't come into fruit anytime soon.
> 
> So let's just remove that test case from 'auto' group, but still keep
> the test case to inform we still have a lot of work to do.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

I'd like to see an ACK from btrfs folks. Thanks!

Eryu

> ---
>  tests/btrfs/group | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/btrfs/group b/tests/btrfs/group
> index 697b6a38ea00..3c554a194742 100644
> --- a/tests/btrfs/group
> +++ b/tests/btrfs/group
> @@ -155,7 +155,7 @@
>  150 auto quick dangerous
>  151 auto quick volume
>  152 auto quick metadata qgroup send
> -153 auto quick qgroup limit
> +153 quick qgroup limit
>  154 auto quick volume
>  155 auto quick send
>  156 auto quick trim
> -- 
> 2.24.1
> 
