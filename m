Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB47949C8
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Aug 2019 18:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbfHSQZ4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Aug 2019 12:25:56 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:39536 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727497AbfHSQZz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Aug 2019 12:25:55 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7JGNuiZ071720;
        Mon, 19 Aug 2019 16:25:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=Kk0EjIs8WXx2FtDVW1ZNj6bmeSIpWEr1jMlFx5Cumro=;
 b=ixn1xui/omb33D2J/IbqyIELZxKMNcceVuySICkEC7MLbsk91vgrBIv3OrI0LnKS2/Sn
 m9CynXveVB8rxPqdKXDd8ADaePeewjxcjEme2mpTKv24W/VfeTPUzdbhx8k9/WXj4ykb
 8MSi+PUkpKn0gXNUw8IHCjNUnIgwLIFJP2SR63y+9eP/aEA+btTW86tg5r4+M8ExkLVe
 XvjfYB4mXn8PtAWyhN4p2jGcBnToRmNvY0KhKlhE4ocsCgpkjFTZ9qy/Bdt8XusNACR5
 XAnmTFoiIuyHfhLR1va7OyGOxTjjWBJylvbjIPZrWojd73znQrBaBDsA9DRJcYF8cA31 fw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2uea7qghk4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Aug 2019 16:25:50 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7JGMvsl063562;
        Mon, 19 Aug 2019 16:25:49 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2ufwgc41wu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Aug 2019 16:25:49 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x7JGPmX6030979;
        Mon, 19 Aug 2019 16:25:48 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 19 Aug 2019 09:25:47 -0700
Date:   Mon, 19 Aug 2019 09:25:46 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Eryu Guan <guaneryu@gmail.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, fstests@vger.kernel.org,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] fstests: generic/500 doesn't work for btrfs
Message-ID: <20190819162546.GH15198@magnolia>
References: <20190815182659.27875-1-josef@toxicpanda.com>
 <20190818154016.GB2845@desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190818154016.GB2845@desktop>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9354 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908190175
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9354 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908190175
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Aug 18, 2019 at 11:44:28PM +0800, Eryu Guan wrote:
> On Thu, Aug 15, 2019 at 02:26:59PM -0400, Josef Bacik wrote:
> > Btrfs does COW, so when we unlink the file we need to update metadata
> > and write it to a new location, which we can't do because the thinp is
> > full.  This results in an EIO during a metadata write, which makes us
> > flip read only, thus making it impossible to fstrim the fs.  Just make
> > it so we skip this test for btrfs.
> > 
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > ---
> >  tests/generic/500 | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/tests/generic/500 b/tests/generic/500
> > index 201d8b9f..5cd7126f 100755
> > --- a/tests/generic/500
> > +++ b/tests/generic/500
> > @@ -49,6 +49,12 @@ _supported_os Linux
> >  _require_scratch_nocheck
> >  _require_dm_target thin-pool
> >  
> > +# The unlink below will result in new metadata blocks for btrfs because of CoW,
> > +# and since we've filled the thinp device it'll return EIO, which will make
> > +# btrfs flip read only, making it fail this test when it just won't work right
> > +# for us in the first place.
> > +test $FSTYP == "btrfs"  && _notrun "btrfs doesn't work that way lol"
> 
> I'm wondering if we could introduce a proper _require rule to cover this
> case? e.g. require the fs doesn't allocate new blocks on unlink? or
> something like that. But I'm not sure what's the proper fs feature to
> require here, any suggestions?

I'd be careful with this -- xfs can allocate new metadata blocks on
unlink too -- changes in the free space btrees, expansion of the free
inode btree, etc.  For the 20 inodes in play in g/500 this won't be the
case, but if you had a test that created 20,000 inodes, then that could
happen.

--D

> Thanks,
> Eryu
> 
> > +
> >  # Require underlying device support discard
> >  _scratch_mkfs >>$seqres.full 2>&1
> >  _scratch_mount
> > -- 
> > 2.21.0
> > 
