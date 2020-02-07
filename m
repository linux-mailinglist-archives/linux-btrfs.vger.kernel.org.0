Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB70115508C
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Feb 2020 03:10:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbgBGCKO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Feb 2020 21:10:14 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:37902 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727028AbgBGCKO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Feb 2020 21:10:14 -0500
Received: by mail-qk1-f196.google.com with SMTP id 21so770187qki.5
        for <linux-btrfs@vger.kernel.org>; Thu, 06 Feb 2020 18:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Bzp60jIPY0ijpd1Xz7Ps7kvYjlALeehugg4Cz7HfZ+k=;
        b=BKUv4Vj6j3AG3fvwWanDUdWCn+t21VSZGVGOIwSC6Sr4B5IFL5cDosm+k94m068Iem
         EJB+a19B5aRDBnR1OpXQdzV/msdsCPsU880aHc7sxc7rkVNnJzY09tHiphAPQPfwJ2hw
         GkH6m2LXrSk/d80IR5dImMFPtCRGV0n7NzQ66dJzRCxlzNQvuSkic/QAGD2xY6llmXA9
         +RSmJtM95wZrPx3btBb+2XdSzojGrKV/YHa37cNwkeGuZZxzg/v3h9HjC1b4kd6jmBmY
         OLvw2BF78uB/BsRqnMAPRp1oOtsABCOiDBQEil9XSNaOeVRM7WCzw5DWHeD4HDanm804
         2kEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Bzp60jIPY0ijpd1Xz7Ps7kvYjlALeehugg4Cz7HfZ+k=;
        b=hU4ldilwOF82Ab/87iUA49OSc6Xlazm5ys+4tqbgFVYO7005Tu5r70cPSMEBcldT8g
         A8p+OOaStuglVDfsc8C5jg5MAtEFxGrr4alsDrW2BlKyWLb1eo9NGBHfnttJuR0MdwFT
         A+DGPaPK552E6NttKw3G/L+5jhxfkpXGhaq92M6+wHmUReRO5FwgByKeNeqwSYFwvHOF
         dPVWyt9uK2bIWy7i2jPPLOryCtZc2wj+gvBunQxUZaMsDDKdyCqUiNehEY0xYA5QvU7C
         r8Iy2pwyinvof3CHS3Fd8CIVR9pvRMD7imry23i7dkjJW6XAJF5af/K/NB+Vcs0zi8sZ
         2fvg==
X-Gm-Message-State: APjAAAWLiXrnkngiPDq8BPksblIbyFB6ulB+FRzou51I/5BU+Odpd3ol
        62La+7ntw8HLSRk4buUSCQW0p0QI+jI=
X-Google-Smtp-Source: APXvYqxl0sis2dUipkaE5wXUOR6R6Wdp1gw954zJ9R/n+WrQ1H6ysCpjvR9jSeBlz+75Yux70uOFYQ==
X-Received: by 2002:a05:620a:996:: with SMTP id x22mr4251711qkx.127.1581041412704;
        Thu, 06 Feb 2020 18:10:12 -0800 (PST)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id b17sm622816qtr.36.2020.02.06.18.10.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2020 18:10:12 -0800 (PST)
Subject: Re: [PATCH 2/3] fstests: btrfs/022: Match qgroup id more correctly
To:     Qu Wenruo <wqu@suse.com>, fstests@vger.kernel.org,
        linux-btrfs@vger.kernel.org
References: <20200207015942.9079-1-wqu@suse.com>
 <20200207015942.9079-3-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <99175f4e-00a3-fe9f-7c7f-3c2c87aa31cb@toxicpanda.com>
Date:   Thu, 6 Feb 2020 21:10:11 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200207015942.9079-3-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/6/20 8:59 PM, Qu Wenruo wrote:
> [BUG]
> Btrfs/022 sometimes fails with snapshot's reference mismatch with its
> source.
> 
> [CAUSE]
> Since commit fd0830929573 ("fsstress: add the ability to create
> snapshots") adds the ability for fsstress to create/delete snapshot and
> subvolumes, fsstress will create new subvolumes under test dir.
> 
> For example, we could have the following subvolumes created by fsstress:
> subvol a id=256
> subvol b id=306
> qgroupid         rfer         excl
> --------         ----         ----
> 0/5             16384        16384
> 0/256        13914112        16384
> ...
> 0/263         3080192      2306048 		<< 2 *306* 048
> ...
> 0/306        13914112        16384 		<< 0/ *306
> 
> So when we're greping for subvolid 306, it matches qgroup 0/263 first,
> which has difference size, and caused false alert.
> 
> [FIX]
> Instead of greping "$subvolid" blindly, now grep "0/$subvolid" to catch
> qgroupid correctly, without hitting rfer/excl values.
> 
> Suggested-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
