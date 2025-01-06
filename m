Return-Path: <linux-btrfs+bounces-10734-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C713A0246A
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jan 2025 12:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC82C3A1251
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jan 2025 11:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8143A1DB924;
	Mon,  6 Jan 2025 11:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l3pOOEl0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E101515990C
	for <linux-btrfs@vger.kernel.org>; Mon,  6 Jan 2025 11:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736163506; cv=none; b=jU8wozxe91fEo1Yrl5maBJMs+K3mbYRLvP6csiIucbURc2zQD8ew2JTPsw/rIVLMwYv9kiDi/SWmXGzJhA2fSMzMrig7slHHZcNjK9yFyzWIZCmLaTymrK4QFclVMkd5P21HbLoAWXQSQaifo+jdpNoE73vVWuiqe/SKBhAcdK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736163506; c=relaxed/simple;
	bh=5xssnJCg88wVBmrNfPsNH+OkyEWsP226D05U4l6Mu0s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=g7GRd6RkDoX3O7y1zVnsxTOKrGpySikjBJx4de7P8dALAjNK9AxHsqK4W47zfQihx5Ij3b73z5rBi43BU4vxsQ3xmNjp5om0uMZNFIp3P/tJIDzMSoc/OatvH8Mp/lSJHqEpWx3ivk05EZ5DleIhdjo1Zxe2ZHLwifS838My7UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=l3pOOEl0; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-38633b5dbcfso13716256f8f.2
        for <linux-btrfs@vger.kernel.org>; Mon, 06 Jan 2025 03:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736163503; x=1736768303; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dUop8DfpD4p1SQmq5+Q6zmdSiDGVjAic33D6A/4tNAk=;
        b=l3pOOEl067mg79ZAG4r+c1mWLh+XlxorFZTkvxlMdvXJ+Y8pbFkbn9Av+7tgwIINZC
         2VaIH05QAc847GCIJthxl2SXjHFRrSxK71/Lb8YC8qd2Ba3wjDnpF2qzNKOZDvFagRKi
         15+NqF72SNIgEtuhaQ/vzYNFWH+BmMa8SyHXE1o3pQ9VjabMPdpl/6vjW2VFrKT31+d9
         Bp0MCVotaSnQt79sbwDI6+PwiAqplnZGPpoTAvxogxKSgSTbBP5sh9W00S3LDwOuf92k
         7fZ4BaE9nn/KGaNoraAJiCmU2khwRCUn1kDh2WyE5mg0H/oUwYIUNpQQnJi9vIyNUVIV
         PfgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736163503; x=1736768303;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dUop8DfpD4p1SQmq5+Q6zmdSiDGVjAic33D6A/4tNAk=;
        b=X1MMDcP9NoQicu/DBGXcuIJFgy7gs/wf1/hD4yQzPkOnCcIasGZvfmc0fNlb8YoE7u
         c4kYu8kI0TUbs6Cw3s5sg8SNgZbiXmlJqPQNFN6x97NAypIkHtCoICMkoSMck6UUUXcs
         4hSr7d5zuOxJn2H/6Pt/0k5458VNVuboQdNH3sVnZlPev2/mcw97NVh/VlaCpLLqe4+j
         008lr1y7lIBG2GaKEVuVfb2Utb9hxnZLieowuGde3o1fZWOv0hTGsAQ4JgkePmuGvuI3
         AE/IeiH2sTmiWqpoUsfXXHQgdiWPvwnviAqXH6TzIrI59zHYJaUdZWux34sEIeGNTUlL
         DMNg==
X-Forwarded-Encrypted: i=1; AJvYcCUeg0eTIhCGzRtJ6PxfzUtm715Ee41vGJvbLp0UBEu8CBsr5xm3P7rJTLoAIecdeCMTnb02k/745AqRcQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzkuYoU0einAhnV4C0cZfhfpkkuf8cbqXuq8eKR45sGcOx74n2U
	G1IjpEKFSTLHowc0o7sjeoO0Wbtc+UakjYq21YWYSx5iqzK+fIVpGFYoFTHnPq0=
X-Gm-Gg: ASbGncsi6Lbgc/4GLjXd0gVANcqyPaTPAgyOTAIwjCa8/EqoG8j5q9eCgg5fqPdlOC8
	9Swh6Xf/WTXU9SeKbLwDKrHoKID2tI1PFUP4ax8rq4aGDllCRtJTa+cpdu6P4jnbKy1kf5sCB2B
	vO06wBkVp/qolrR2YV14dKAGcct8Pu5HvkbEUHIM273aC4LvaUAmavSt/BfGs3GC7huCdkItx2l
	SwI7TatEjis+fE08kj7MOJAjuM/uL4cWMEfRNlenPDr5vxeFzNzEhW62poa4A==
X-Google-Smtp-Source: AGHT+IE3uyPTe8/NlP3SSeVzlNKmSenBA3eXhrWyLWb2rEnUtsrKKt9sXjVRLN4HNMOuwQCMcD5bzA==
X-Received: by 2002:adf:a3d3:0:b0:38a:5122:5a03 with SMTP id ffacd0b85a97d-38a51225ae4mr17959494f8f.41.1736163503265;
        Mon, 06 Jan 2025 03:38:23 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b3b295sm608853545e9.33.2025.01.06.03.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 03:38:22 -0800 (PST)
Date: Mon, 6 Jan 2025 14:38:19 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Anand Jain <anand.jain@oracle.com>,
	linux-btrfs@vger.kernel.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, dsterba@suse.com,
	Naohiro.Aota@wdc.com, wqu@suse.com, hrx@bupt.moe,
	waxhead@dirtcellar.net
Subject: Re: [PATCH v5 05/10] btrfs: add read count tracking for filesystem
 stats
Message-ID: <f7198ea9-e6f3-4857-af35-0f119e2b88e6@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4010cee5398e35a695def3ad97d4de6f136ae2c.1735748715.git.anand.jain@oracle.com>

Hi Anand,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Anand-Jain/btrfs-initialize-fs_devices-fs_info-earlier/20250102-021904
base:   v6.13-rc5
patch link:    https://lore.kernel.org/r/c4010cee5398e35a695def3ad97d4de6f136ae2c.1735748715.git.anand.jain%40oracle.com
patch subject: [PATCH v5 05/10] btrfs: add read count tracking for filesystem stats
config: i386-randconfig-r072-20250103 (https://download.01.org/0day-ci/archive/20250104/202501040304.Ju24l8yd-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202501040304.Ju24l8yd-lkp@intel.com/

New smatch warnings:
fs/btrfs/volumes.c:7691 btrfs_init_dev_stats() warn: inconsistent returns '&fs_devices->device_list_mutex'.

vim +7691 fs/btrfs/volumes.c

124604eb50f88e Josef Bacik    2020-09-18  7663  int btrfs_init_dev_stats(struct btrfs_fs_info *fs_info)
124604eb50f88e Josef Bacik    2020-09-18  7664  {
124604eb50f88e Josef Bacik    2020-09-18  7665  	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices, *seed_devs;
124604eb50f88e Josef Bacik    2020-09-18  7666  	struct btrfs_device *device;
124604eb50f88e Josef Bacik    2020-09-18  7667  	struct btrfs_path *path = NULL;
92e26df43b1a97 Josef Bacik    2020-09-18  7668  	int ret = 0;
124604eb50f88e Josef Bacik    2020-09-18  7669  
124604eb50f88e Josef Bacik    2020-09-18  7670  	path = btrfs_alloc_path();
124604eb50f88e Josef Bacik    2020-09-18  7671  	if (!path)
124604eb50f88e Josef Bacik    2020-09-18  7672  		return -ENOMEM;
124604eb50f88e Josef Bacik    2020-09-18  7673  
124604eb50f88e Josef Bacik    2020-09-18  7674  	mutex_lock(&fs_devices->device_list_mutex);
92e26df43b1a97 Josef Bacik    2020-09-18  7675  	list_for_each_entry(device, &fs_devices->devices, dev_list) {
92e26df43b1a97 Josef Bacik    2020-09-18  7676  		ret = btrfs_device_init_dev_stats(device, path);
92e26df43b1a97 Josef Bacik    2020-09-18  7677  		if (ret)
ec90aa75ef29fb Anand Jain     2025-01-02  7678  			return ret;

mutex_unlock(&fs_devices->device_list_mutex);

92e26df43b1a97 Josef Bacik    2020-09-18  7679  	}
124604eb50f88e Josef Bacik    2020-09-18  7680  	list_for_each_entry(seed_devs, &fs_devices->seed_list, seed_list) {
92e26df43b1a97 Josef Bacik    2020-09-18  7681  		list_for_each_entry(device, &seed_devs->devices, dev_list) {
92e26df43b1a97 Josef Bacik    2020-09-18  7682  			ret = btrfs_device_init_dev_stats(device, path);
92e26df43b1a97 Josef Bacik    2020-09-18  7683  			if (ret)
92e26df43b1a97 Josef Bacik    2020-09-18  7684  				goto out;
124604eb50f88e Josef Bacik    2020-09-18  7685  		}
92e26df43b1a97 Josef Bacik    2020-09-18  7686  	}
92e26df43b1a97 Josef Bacik    2020-09-18  7687  out:
733f4fbbc1083a Stefan Behrens 2012-05-25  7688  	mutex_unlock(&fs_devices->device_list_mutex);
733f4fbbc1083a Stefan Behrens 2012-05-25  7689  
733f4fbbc1083a Stefan Behrens 2012-05-25  7690  	btrfs_free_path(path);
92e26df43b1a97 Josef Bacik    2020-09-18 @7691  	return ret;
733f4fbbc1083a Stefan Behrens 2012-05-25  7692  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


