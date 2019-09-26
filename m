Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3E0BF92C
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Sep 2019 20:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbfIZS27 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Sep 2019 14:28:59 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:44124 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfIZS27 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Sep 2019 14:28:59 -0400
Received: by mail-qt1-f196.google.com with SMTP id u40so4045638qth.11
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Sep 2019 11:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9feDFC1CEhLXRFlh1hAk1Xj2AaHVm4GnUnjjvfUvFbQ=;
        b=cM4NSKDj5J/yi64EaofwS80L9WmPM7bvoGyP0pE3OfXFktg0ZGZM1o7v302fbHZQyA
         pBFnaQ6aRxsHflHhKwV9xpEowEwPigY0aLxf7Mv+7uV5TkmLkHpAtiA9u3eq2PFGeDca
         Tz7Wcet1EQnWI7d338pHjOWlsBOxw8IdFN+acILXDAOyupgtfezxn+B/BTsNNhnFZWSS
         m1+ASkNw8e3fgWUgAZVrP7acaJ5NSI1DL+TRN+3195k7vd43njlP+Slwc3nBgrSOZx6x
         IKqxvHt4AwKUnazlOPw5rK8UHSUS/k9v/qnRhmjnxGVLsBS8aHTwCd63osGHELQFMB2t
         50xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9feDFC1CEhLXRFlh1hAk1Xj2AaHVm4GnUnjjvfUvFbQ=;
        b=jmWmm3TLCkszFtI0NeB3bEG941lzK+HfnbbHsNaVWUbGo/Yt0UqG8Zzp0/fzSYKRim
         AJhakVwgM7Of3UiiI1OaZw/2J9Q+dBJ3f7QwcD7H91lbU2RidEOBkmooG7nnlmDiBGgx
         34aKPqTT2oD606Qh7kTtl9iuGNXUAiRwgcPF+rDP4UFQn1I/CIyFk9eEJc4IlQvKxEq0
         6nNCyG7DGJGQb19CcuZtbyI2E3FITym40yOmR8CXsuaj2J44d7EGvTgVOyYR6HtC0sUH
         UXy/WVTZ1hQqWbJN7Mio1SKYvoZ453zd4Te7vEC+baXMe58STzOCAk4jrQh0KMJIWuy8
         g7Kw==
X-Gm-Message-State: APjAAAWHnDnPcIKuhuI6WruhkEbpOF8/A9perQnjbcdsBOL30yvf7zut
        MUXfIt6gTLLWyY4CwmZuO142WAdQEhw9qg==
X-Google-Smtp-Source: APXvYqz9Jo4ei0uvAP9/kmkagHvRi3MhAnwqoc5GtwPcpFnhmpCuJN88ce3LGMSnAzM/eYAUrGPI3A==
X-Received: by 2002:a0c:c590:: with SMTP id a16mr4104933qvj.144.1569522536757;
        Thu, 26 Sep 2019 11:28:56 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::c9a9])
        by smtp.gmail.com with ESMTPSA id v13sm1215262qtp.61.2019.09.26.11.28.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Sep 2019 11:28:56 -0700 (PDT)
Date:   Thu, 26 Sep 2019 14:28:54 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 3/3] btrfs: Return offset from find_desired_extent
Message-ID: <20190926182853.be53llywifww6nve@macbook-pro-91.dhcp.thefacebook.com>
References: <20190926113953.19569-1-nborisov@suse.com>
 <20190926113953.19569-4-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190926113953.19569-4-nborisov@suse.com>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 26, 2019 at 02:39:53PM +0300, Nikolay Borisov wrote:
> Instead of using an input pointer parameter as the return value and have
> an int as the return type of find_desired_extent, rework the function
> to directly return the found offset. Doing that the 'ret' variable in
> btrfs_llseek_file can be removed. Additional (subjective) benefit is
> that btrfs' llseek function now resemebles those of the other major
> filesystems.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
