Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69A4B1784C2
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Mar 2020 22:19:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732533AbgCCVTG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Mar 2020 16:19:06 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36860 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732484AbgCCVTG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 Mar 2020 16:19:06 -0500
Received: by mail-qt1-f193.google.com with SMTP id t13so4064138qto.3
        for <linux-btrfs@vger.kernel.org>; Tue, 03 Mar 2020 13:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yxnmMHwhlhd0SaiT3QcuplAibur0J32QbP/LmVla2Wg=;
        b=CbnqePb7z5JAAgC66wbJrd9xsyGwNUeTllwqNiuSAJuWRes7Wfu3yERu4e0RhFnPSe
         KYB6O3i1aFuhhGC8AzIq6BCf+ATRvmP+0TDcZev8EFgyyv7MPzOWawdZw76S/+mH9NCv
         fs7LfSrRYuZXJoUCc01nYdyulSF2xYlrk8ZBffz52K4jbtzVurZFeXYqRDXlFKF6w5Y0
         WJCE6FGEtK2hhtRNbJd3z00hcFXBlLxMR+3MHry5RumYNCqOJvwHRc4c+VjC74x9FogM
         e0Kb63scxLVdXf8/h7TwlYdKJwcqjVk8vsYWnGljnIloaS6FC2kztBce7C/v4sxDJdS3
         T17A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yxnmMHwhlhd0SaiT3QcuplAibur0J32QbP/LmVla2Wg=;
        b=pIHo6liMKWql+A14U1IKrQVswzVqdNFdcaUFE+U5GzRP6flUkaOO+rBBMhntHTyu4Y
         bf1B+UsWoj3OSX5dLLkur+ajJznd/Bk6JIgsWTuRmWDA3VeivnbwGmXxhqZzlUk5RFL/
         SEw/ekE4xyM7jsaHTeFy6y9dzYD5911jXB+MNwmiLiFLHg9AwWLxFEOSwCL4KFW1fWSC
         5m/1ves0e6FwR3nB9qEpwcZ7GXKL8Xk77cnT/EFNn8fzBCfel0expBt8hlr25sX7xY01
         DKtNxesb2Gya5G7IyXbXdwnEDUR3Wd0S6dAeWcC8wA7//vp2rHerslQjVGex40D+idyI
         VaRA==
X-Gm-Message-State: ANhLgQ2di7k6UK5gIAIIcb5MUAVlHGuksr1OolnyQ57KCnFcK2lFLzJX
        eqsCWFavF4QjgaiJpn1pAWTjjg==
X-Google-Smtp-Source: ADFU+vtyv6ViHr3DePSdjzq4wDPjYGl73tmDBr3pZGPHC2LtxgVKX+QWAa2Dj436VcAjOh0+lBYX/g==
X-Received: by 2002:ac8:b8d:: with SMTP id h13mr6327640qti.298.1583270345277;
        Tue, 03 Mar 2020 13:19:05 -0800 (PST)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id f5sm10642686qka.43.2020.03.03.13.19.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2020 13:19:04 -0800 (PST)
Subject: Re: [PATCH v3 3/3] Btrfs: implement full reflink support for inline
 extents
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
Cc:     Filipe Manana <fdmanana@suse.com>
References: <20200224171327.3655282-1-fdmanana@kernel.org>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <5e044000-09e8-ade1-69a6-44cfc59fdc48@toxicpanda.com>
Date:   Tue, 3 Mar 2020 16:19:03 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200224171327.3655282-1-fdmanana@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/24/20 12:13 PM, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> There are a few cases where we don't allow cloning an inline extent into
> the destination inode, returning -EOPNOTSUPP to user space. This was done
> to prevent several types of file corruption and because it's not very
> straightforward to deal with these cases, as they can't rely on simply
> copying the inline extent between leaves. Such cases require copying the
> inline extent's data into the respective page of the destination inode.
> 
> Not supporting these cases makes it harder and more cumbersome to write
> applications/libraries that work on any filesystem with reflink support,
> since all these cases for which btrfs fails with -EOPNOTSUPP work just
> fine on xfs for example. These unsupported cases are also not documented
> anywhere and explaining which exact cases fail require a bit of too
> technical understanding of btrfs's internal (inline extents and when and
> where can they exist in a file), so it's not really user friendly.
> 
> Also some test cases from fstests that use fsx, such as generic/522 for
> example, can sporadically fail because they trigger one of these cases,
> and fsx expects all operations to succeed.
> 
> This change adds supports for cloning all these cases by copying the
> inline extent's data into the respective page of the destination inode.
> 
> With this change test case btrfs/112 from fstests fails because it
> expects some clone operations to fail, so it will be updated. Also a
> new test case that exercises all these previously unsupported cases
> will be added to fstests.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
