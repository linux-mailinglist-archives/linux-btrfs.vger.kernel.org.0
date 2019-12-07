Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54BF9115D93
	for <lists+linux-btrfs@lfdr.de>; Sat,  7 Dec 2019 17:44:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbfLGQou (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 7 Dec 2019 11:44:50 -0500
Received: from ms11p00im-qufo17291801.me.com ([17.58.38.47]:60052 "EHLO
        ms11p00im-qufo17291801.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726414AbfLGQou (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 7 Dec 2019 11:44:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1575737088;
        bh=NAEyDaBHiFqn+s6dHzA3hQZgdPsc82LWBou1lxeWXNM=;
        h=Content-Type:Subject:From:Date:Message-Id:To;
        b=wSHe4ovUC5a7C18P2D9UoroAnHQ/kvViNqB4ceezz5dmPhce7nPg4fZm88xA+GM/D
         rhXk+GKZhKcd1tznl5/76pU1TMkbxElt6UoiALhvWnFjT2EcQLgfdQJztXaAUwht0t
         6q3zBrgEtqX+dR8jJtD88FnWa8wOcaJZiqqkHSCI9ENLD4X9J1nFqrto1wU8I7cJPS
         +2N8Ob2CkM51duk1VorAdQahPHEz35lZpzNQxt7gHHdeDw2PTOOedieS6p1PgB5TI4
         VBOaLf2s3lm7N2KCTROW+2zq7Xo33RnB6PeK8/eKl9r/zSe0qd4bJtwVeg2bAUwt1K
         n6LLbwPMt7kLA==
Received: from [192.168.15.24] (unknown [177.27.216.49])
        by ms11p00im-qufo17291801.me.com (Postfix) with ESMTPSA id DEE81AC0D78;
        Sat,  7 Dec 2019 16:44:46 +0000 (UTC)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3601.0.10\))
Subject: Re: [PATCH] btrfs-progs: Skip device tree when we failed to read it
From:   Christian Wimmer <telefonchris@icloud.com>
In-Reply-To: <e8b667ab-6b71-7cd8-632a-5483ec4386d8@gmx.com>
Date:   Sat, 7 Dec 2019 13:44:44 -0300
Cc:     Qu WenRuo <wqu@suse.com>, Anand Jain <anand.jain@oracle.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <6538780A-6160-4400-A997-E8324DB61F69@icloud.com>
References: <20191206034406.40167-1-wqu@suse.com>
 <2a220d44-fb44-66cf-9414-f1d0792a5d4f@oracle.com>
 <762365A0-8BDF-454B-ABA9-AB2F0C958106@icloud.com>
 <94a6d1b2-ae32-5564-22ee-6982e952b100@suse.com>
 <4C0C9689-3ECF-4DF7-9F7E-734B6484AA63@icloud.com>
 <f7fe057d-adc1-ace5-03b3-0f0e608d68a3@gmx.com>
 <BF872461-4D5F-4125-85E6-719A42F5BD0F@icloud.com>
 <e8b667ab-6b71-7cd8-632a-5483ec4386d8@gmx.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
X-Mailer: Apple Mail (2.3601.0.10)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-12-07_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=728 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1912070145
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Qu,

I was reading about chunk-recover. Do you think this could be worth a =
try?

Is there any other command that can search for files that make sense to =
recover?

Regards,

Chris

