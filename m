Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96663D1FFA
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2019 07:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbfJJFVq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Oct 2019 01:21:46 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:43293 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbfJJFVq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Oct 2019 01:21:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1570684905; x=1602220905;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rvS7/zKzQia6C+r6d3i+Hc7lCDl6/xXC7qNJCWX16po=;
  b=p/+GpF4UImXJqy7MybAJCb0zMqv+atlz+7Z34NO9zx92m017nKoCaqwa
   ueQd0hCunqmSFzb95P5mU5rJbB6PbX/AQFMtEVCmXdRBLUkt6BipdyUDq
   8/K5ob59Y7UdtN2wNGE4nJtgCcDRfpPLa9Zs+79948mRlguv4iY+CRNzA
   +RPLIN3L2wNQwhF96it5ZLvbEcWc9GOkIHK3xFx5bNcy6gV0mSRSgJn/L
   VCairztnzd+hbE3IT05PRCTGEJ46UfdzOeNUS4I29zGVUcdhUdXQs3GFa
   BaEPZIuSI0jbo6633uC3MutxsLV1nu2V8HN9IvLf1Cc2MJLNQeCUznWbe
   w==;
IronPort-SDR: kcwEuFSFy0d+UDpL//b6pflzpgWXseLUp7zZUBKNNewrILz8kKFH1kKz5zYRvK3PyTT3lur7AE
 XbkIbGhwgZn5mXyWysIqTneor/MY7YVjESBQNVzsT5LmVRgbScjzTnHhe9BokdJswrWeqJBVQo
 bVCab8bZYk0Wk+U9BZ3BgFoUIWMTNOhEfpLIpzKpkmBwm7DDZvSGq6jHiS70Ahb5SD6nGyBIDu
 1Vmu9dJkXCphfL4Yd4a5dQajf39i7KnjGtE73YKkUHWd9BuDmUO+gy+Ge1KxgRRJgjSv7PeSF8
 PNs=
X-IronPort-AV: E=Sophos;i="5.67,279,1566835200"; 
   d="scan'208";a="227207044"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Oct 2019 13:21:45 +0800
IronPort-SDR: ZbUEpBLfxb1zYF59UPlFeM5m3QrmM7wE0f+KWqd7ys81/IFly5mEKeuB1bWCzXicggXgriIw2r
 YzIQW747R9lmX19j1GcDOCqXeD57sbVa5XivsHJu54DTJ66T1dbfbO+i6KzeMDQW/zDfFKsuE5
 5L8wLaZne2yLPnEXENj/Xtq8y5PQPLdyUBSafw4sMGDBQIHBlTyNa2NM63RAtpftocDGAG3C7t
 Nl98a7ktS0sEA+O7j3FRoO9cmrJHF3ygIYSqOmJeGez/IN2+1Yf2BA4oJ91stg434MrEUZbtmr
 vL/ZyUXX2rCZ38dmozIarPMb
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2019 22:17:43 -0700
IronPort-SDR: VI+6DmNKBGjwz+sfqT89x0RI8MQdj1rFiHgA5/fi+ARFFiYDPTB9La7IVoXKwlQ4kflEy+a6zr
 TyghvA2DcD8xk2ABJFblR7gL3X/b2AH4LtCkV5UvLxFjTrkTBFpVdKj8VeWvBb82S84Kzs96RK
 3bgynDnsykxzBgrNRNWNqdW+WuzqkJdoNbDQzOyyo8SuW4ougxB3yBfdb4x9yQy4mkwzFVDIIo
 P44IgZWoYJEo0KB+92B9Gu2m7dnwcYiUf1J++ex6qzJMqQITrgJeyR6GnbFuAGrxEktNi31zjN
 kTs=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with SMTP; 09 Oct 2019 22:21:45 -0700
Received: (nullmailer pid 15312 invoked by uid 1000);
        Thu, 10 Oct 2019 05:21:44 -0000
Date:   Thu, 10 Oct 2019 14:21:44 +0900
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 3/3] btrfs: Introduce new incompat feature, BG_TREE,
 to speed up mount time
Message-ID: <20191010052144.wl6wq6leoqjqgsz3@naota.dhcp.fujisawa.hgst.com>
References: <20191010023928.24586-1-wqu@suse.com>
 <20191010023928.24586-4-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191010023928.24586-4-wqu@suse.com>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 10, 2019 at 10:39:28AM +0800, Qu Wenruo wrote:
>diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
>index b65c7ee75bc7..1d1e50c42d0e 100644
>--- a/include/uapi/linux/btrfs_tree.h
>+++ b/include/uapi/linux/btrfs_tree.h
>@@ -48,6 +48,9 @@
> /* tracks free space in block groups. */
> #define BTRFS_FREE_SPACE_TREE_OBJECTID 10ULL
>
>+/* sotre BLOCK_GROUP_ITEMs in a seprate tree */
>+#define BTRFS_BLOCK_GROUP_TREE_OBJECTID 11ULL
>+

nit: "store" and "separate"?

> /* device stats in the device tree */
> #define BTRFS_DEV_STATS_OBJECTID 0ULL
>
>-- 
>2.23.0
>
