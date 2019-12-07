Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D169D115D24
	for <lists+linux-btrfs@lfdr.de>; Sat,  7 Dec 2019 15:26:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbfLGOZ6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 7 Dec 2019 09:25:58 -0500
Received: from ms11p00im-qufo17281701.me.com ([17.58.38.54]:58635 "EHLO
        ms11p00im-qufo17281701.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726397AbfLGOZ6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 7 Dec 2019 09:25:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1575728756;
        bh=meXdMziLFxFb9/BRGkpQZo5oqM8MuLdBTre49uaIsPs=;
        h=Content-Type:Subject:From:Date:Message-Id:To;
        b=GhQAuMtI6/UxCrOkl8CnWtAgq2RuW5i/SZ4qr//OUPMa/2AwOKPUC7hC3r3Tm1RJT
         9F/U1YtqWt8y5Xh6VWki+j6M67peuCTttycqCtqZeqH9rVrms6OpTHDPkeSdg3VAgC
         97zkrPui6yBY+AwWfuCws+l31Z/1iGlxpvbWl7dqPNxWpZYi7rSxLVF7B8p6VVp+Fc
         zjD8ONiNc+mWVVkQUulGs9SJ/08zstKoXFnSCh9IpLaBT/345H8fvsIxlU0NtkgDZK
         S+4BnZO64sUNMtQBqpyy5sSpR53enkIa0Y8mQhuYDCckuGnrPVnIUE9kjIEQhVbDfy
         ldElDtF4S2Inw==
Received: from [192.168.15.24] (unknown [177.27.216.49])
        by ms11p00im-qufo17281701.me.com (Postfix) with ESMTPSA id 25713BC0959;
        Sat,  7 Dec 2019 14:25:54 +0000 (UTC)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3601.0.10\))
Subject: Re: [PATCH] btrfs-progs: Skip device tree when we failed to read it
From:   Christian Wimmer <telefonchris@icloud.com>
In-Reply-To: <e8b667ab-6b71-7cd8-632a-5483ec4386d8@gmx.com>
Date:   Sat, 7 Dec 2019 11:25:52 -0300
Cc:     Qu WenRuo <wqu@suse.com>, Anand Jain <anand.jain@oracle.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <43F59C34-A80B-4D79-B57F-7BCDDF8804FF@icloud.com>
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
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-12-07_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=941 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1912070125
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

ok, backup device did not work  as well.

Any ideas?

The organisation was like this:

mount /dev/sde1 /home/promise

inside /home/promise was a subvolume =E2=80=9Cprojects=E2=80=9D like:

/home/promise/projects

and inside /home/promise/projects was .snapshots with the snapshots of =
it.

Anything that I could recover would be fine (but this you know already).

Thanks,

Chris

