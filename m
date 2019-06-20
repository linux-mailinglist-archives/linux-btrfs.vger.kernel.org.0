Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06DF94D477
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Jun 2019 19:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbfFTRCy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Jun 2019 13:02:54 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46475 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbfFTRCx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Jun 2019 13:02:53 -0400
Received: by mail-pf1-f193.google.com with SMTP id 81so1992253pfy.13;
        Thu, 20 Jun 2019 10:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8wf4cUw4MBLQ5ZMRZPNnEwMB/4TzHc3tHqQ0sOQp8Os=;
        b=Wg6NBK6vKlCLiPsPaXNE5QvvdM2CnFaRmcfdeCBn9IjI1jcuHtXo7vm10THbVibgnu
         u0U7RfwHLhckYVSyanRghxO5KKgFrrx1Tx4JOIjTIzPy1Od9dftVLvCn9tWRZ1vUSSXU
         d+3feEShEKF3XAyfMZcDewHa0x/55pg6P0pN0kSQShr+btUn26moy4nPnGaKIoul6YM/
         Pr7GbJHYFwpcwYnHcejjSWyjTgcRVINTrfM+oS3oYJ7kIpqZStAf0KLTrI3+NwphEEyA
         5vV47bnRpY8qlF/5PnVI9gwXpelTqwQ0RNcBW8OiyK6J3jOOUcERQ6pfuTPhiI5JtpkL
         dzag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=8wf4cUw4MBLQ5ZMRZPNnEwMB/4TzHc3tHqQ0sOQp8Os=;
        b=EGGdUTVV4rNbNCSm13F0Ykg4l5k1/ltY/+3LhvFDm+AZ+ndEKypiAdOTuyufOnkwnx
         /b0Bgt+dUw1naLiA/HLZjhpSRkfyEcrw4nNlGBbeuxOAf8iJzySK24ETOF9RH2Y/HvEN
         GnjxPwAGQIz0fh+7wJnY5qiJ6vzQ8ZGdKH8YhKQqoORYXl5rA/jxL+mJhoZ+1A3fikcq
         Iys1cvUGmIwXbnEHr+ZkzIgB4geiJfbIlgTgLaqZe6obVOb+CHvyfSafq6rVsvJJq3uX
         jb40JjYCRNvA0GyUxo+JamDCQggv5rSC0fPPrt+lQ8fNDkd9eL5+xff04znr77MKkerz
         liLQ==
X-Gm-Message-State: APjAAAV2TFVkq6iusIwF7AZZ4GzK8CX3GGxUwPWAnHiQQw1oy5pa64RR
        L6Paui0G/AT5fk1udigv8h2ED2K1zI4=
X-Google-Smtp-Source: APXvYqzo7LjGo49CmlMqmYF7gjPoklzF78RZuEScWmDOaqfh7XoF3z//V+4KuxJQBWcA7NOcTxhIvg==
X-Received: by 2002:aa7:8157:: with SMTP id d23mr131848775pfn.92.1561050172819;
        Thu, 20 Jun 2019 10:02:52 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::3:8402])
        by smtp.gmail.com with ESMTPSA id p27sm27462pfq.136.2019.06.20.10.02.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 10:02:52 -0700 (PDT)
Date:   Thu, 20 Jun 2019 10:02:50 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     dsterba@suse.com, clm@fb.com, josef@toxicpanda.com,
        axboe@kernel.dk, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 2/9] blkcg, writeback: Add wbc->no_wbc_acct
Message-ID: <20190620170250.GL657710@devbig004.ftw2.facebook.com>
References: <20190615182453.843275-1-tj@kernel.org>
 <20190615182453.843275-3-tj@kernel.org>
 <20190620152145.GL30243@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190620152145.GL30243@quack2.suse.cz>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello, Jan.

On Thu, Jun 20, 2019 at 05:21:45PM +0200, Jan Kara wrote:
> I'm completely ignorant of how btrfs compressed writeback works so don't
> quite understand implications of this. So does this mean that writeback to
> btrfs compressed files won't be able to transition inodes from one memcg to
> another? Or are you trying to say the 'wbc' used from async worker thread
> is actually a dummy one and we would double-account the writeback?

So, before, only the async compression workers would run through the
wbc accounting code regardless of who originated the dirty pages,
which is obviously wrong.  After the patch, the code accounts when the
dirty pages are being handed off to the compression workers and
no_wbc_acct is used to suppress spurious accounting from the workers.

> Anyway, AFAICS no_wbc_acct means: "IO done as a result of this wbc will not
> have influence on inode memcg ownership", doesn't it?

Yeap.

Thanks.

-- 
tejun
