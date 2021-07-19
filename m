Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24ECD3CDC5C
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Jul 2021 17:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238199AbhGSOwL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Jul 2021 10:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344495AbhGSOsx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Jul 2021 10:48:53 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B791C05BD11
        for <linux-btrfs@vger.kernel.org>; Mon, 19 Jul 2021 07:41:53 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id s193so16984113qke.4
        for <linux-btrfs@vger.kernel.org>; Mon, 19 Jul 2021 08:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6TU+DfCVectcnCezxhRvyNwyncgH6ZkTsuKOnZwUCUU=;
        b=eK2kA8JTL7t76ftvWPYkgnD9wPpgsc3Yj8U2Hwuns0EatZYLtSPhU+5MPmI/1q885r
         u2wvddqKt8c7bxcyHPsibsuUvkla+UhIS7D0K5hQQtpA0Qeop2xR1LWT6vuC0ldL73wt
         4uQUCV8BQS0MCG8BDj7qc4++tf7uKjU1CMRS2fQwhTUyV89+bnwOE3nDsuhasLoV+v10
         RfX0c9oea515CpCZfKnZ9T0QWwjNLGPaBMDooMuh60qZLe8u76BdFk67LqNGuHB6CoFk
         IWf6NRle4e5e2owKXOPaH+t1uWNp4wv8it+KINOsQKPX2WBL8EFY3l1huqImvNs+6T1z
         RzAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6TU+DfCVectcnCezxhRvyNwyncgH6ZkTsuKOnZwUCUU=;
        b=uNplJMquGvgrzm54umk+J4hQ/ajU/77Z8MfXurDyXFHOCMJaFuhowScdmSK5FHk82p
         +7QDeLCsGbbzbAQC/DMN/DP+npA+qoJlDyY0dlCvZFZTOVkCJrWWePM9xgf6AwSZ8kQ/
         k15Je9SV9vZfjda/pgNN2DX/HYCckRQ5Ypbn9b5heMeKgj+uFp3iKTzyBl3OJB6uORAE
         9B4QV9AqHAsH+9FI4lb4fHzrBwz7q06x18pA34tDjtTfn6QmYPuj8wLDuF0evWs54lp2
         UffD9/C6pG1K6d1HSYGNkF3UVFysy+NTZZrxiL7H+i6cYvz3DExPTD5NiR4GhrNnAgWS
         qi8Q==
X-Gm-Message-State: AOAM531hT/ldDW15buXS8KJ2EXtwpHr3nrsEr8LLyH2hXXU0a3r6eT2b
        c4JiokPb3+zZDLkVVeFB1mIMXg==
X-Google-Smtp-Source: ABdhPJzgPI1RUHz0I90XrEKV0s2e8/8gI5Yecs25DthgFqA5fYLVELZeYx1ZaTsWpJJCvOOw+aJQfA==
X-Received: by 2002:a05:620a:13f5:: with SMTP id h21mr7074275qkl.252.1626707516707;
        Mon, 19 Jul 2021 08:11:56 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id b3sm6592230qto.49.2021.07.19.08.11.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jul 2021 08:11:56 -0700 (PDT)
Subject: Re: [PATCH v2 00/21] btrfs: support idmapped mounts
To:     Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-btrfs@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
References: <20210719111052.1626299-1-brauner@kernel.org>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <a56d9480-ecc3-cfca-39ae-82a46f9cfd6c@toxicpanda.com>
Date:   Mon, 19 Jul 2021 11:11:54 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210719111052.1626299-1-brauner@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 7/19/21 7:10 AM, Christian Brauner wrote:
> From: Christian Brauner <christian.brauner@ubuntu.com>
> 
> Hey everyone,
> 
> This series enables the creation of idmapped mounts on btrfs. On the list of
> filesystems btrfs was pretty high-up and requested quite often from userspace
> (cf. [1]). This series requires just a few changes to the vfs for specific
> lookup helpers that btrfs relies on to perform permission checking when looking
> up an inode. The changes are required to port some other filesystem as well.
> 
> The conversion of the necessary btrfs internals was fairly straightforward. No
> invasive changes were needed. I've decided to split up the patchset into very
> small individual patches. This hopefully makes the series more readable and
> fairly easy to review. The overall changeset is quite small.
> 
> All non-filesystem wide ioctls that peform permission checking based on inodes
> can be supported on idmapped mounts. There are really just a few restrictions.
> This should really only affect the deletion of subvolumes by subvolume id which
> can be used to delete any subvolume in the filesystem even though the caller
> might not even be able to see the subvolume under their mount. Other than that
> behavior on idmapped and non-idmapped mounts is identical for all enabled
> ioctls.
> 
> The changeset has an associated new testsuite specific to btrfs. The
> core vfs operations that btrfs implements are covered by the generic
> idmapped mount testsuite. For the ioctls a new testsuite was added. It
> is sent alongside this patchset for ease of review but will very likely
> be merged independent of it.
> 
> All patches are based on v5.14-rc2.
> 
> The series can be pulled from:
> https://git.kernel.org/brauner/h/fs.idmapped.btrfs
> https://github.com/brauner/linux/tree/fs.idmapped.btrfs
> 
> The xfstests can be pulled from:
> https://git.kernel.org/brauner/xfstests-dev/h/fs.idmapped.btrfs
> https://github.com/brauner/xfstests/tree/fs.idmapped.btrfs
> 
> Note, the new btrfs xfstests patch is on top of a branch of mine
> containing a few more preliminary patches. So if you want to run the
> tests, please simply pull the branch and build from there.
> 
> The series has been tested with xfstests including the newly added btrfs
> specific test. All tests pass.
> There were three unrelated failures that I observed: btrfs/219,
> btrfs/2020 and btrfs/235. All three also fail on earlier kernels
> without the patch series applied.
> 
> Thanks!
> Christian

Thanks for this work Christian, you can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

to the series.

Josef
