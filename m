Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2F6D724D6
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jul 2019 04:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725878AbfGXCmk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Jul 2019 22:42:40 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:35626 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbfGXCmj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Jul 2019 22:42:39 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6O2YDMc137861;
        Wed, 24 Jul 2019 02:42:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=OWoteWsLQ3S+bMfIAr8F21n9P1w9uNsn85bwL3v/2yk=;
 b=Bgnr8P4dVbw5x4Nm+rRpN0Wtdz+/wa8zzAXbnj+i1aRFG7VDN+PvQw+3HD5ST23Wq+K0
 eZ2OIBy65nv2/R8PwNAaKdbgt4XLdfC+DNPf4FsgX0csX9qFFZEEUPonnzxCNK5btfcC
 MWTibdlwEbSkeVKjSXzjvUZ7nFuYHu7vC0fgz9vbSzop71MA0S/Rve8WtMcV8ymXMJr6
 K5B74rXiGm33Qqs2kjqGgtDJMrrhzr6nihsnCXPNz2PtOMWWuDizmUCR1k9RKpJuy4Mj
 3sdEcYg9Au7hQfcGbawZ887W7S8O+p+nZJJyjHGZfJpn8lJ67+VOqQtkQUBUVcJQWPeX hA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2tx61bt9qd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Jul 2019 02:42:35 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6O2bmrx134665;
        Wed, 24 Jul 2019 02:42:35 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2tx60xkw89-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Jul 2019 02:42:35 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x6O2gXpd000539;
        Wed, 24 Jul 2019 02:42:34 GMT
Received: from [10.190.130.61] (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 23 Jul 2019 19:42:33 -0700
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 2/3 RESEND Rebased] btrfs: add readmirror property
 framework
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20190723145731.GF2868@twin.jikos.cz>
Date:   Wed, 24 Jul 2019 10:42:29 +0800
Cc:     linux-btrfs@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <6B6DCA46-1EB6-4C7E-B859-B3D3ED6B1332@oracle.com>
References: <20190626083402.1895-1-anand.jain@oracle.com>
 <20190626083402.1895-3-anand.jain@oracle.com>
 <20190723145731.GF2868@twin.jikos.cz>
To:     David Sterba <dsterba@suse.cz>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9327 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1907240028
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9327 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1907240028
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



> On 23 Jul 2019, at 10:57 PM, David Sterba <dsterba@suse.cz> wrote:
>=20
> On Wed, Jun 26, 2019 at 04:34:01PM +0800, Anand Jain wrote:
>> Function call chain  __btrfs_map_block()->find_live_mirror() uses
>> thread %pid to determine the %mirror_num for the read when =
mirror_num=3D0
>> in the argument.
>>=20
>> This patch introduces a framework so that readmirror is a =
configurable
>> parameter, with default set to pid.
>>=20
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>> fs/btrfs/props.c   | 41 +++++++++++++++++++++++++++++++++++++++++
>> fs/btrfs/volumes.c |  9 ++++++++-
>> fs/btrfs/volumes.h |  6 ++++++
>> 3 files changed, 55 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/fs/btrfs/props.c b/fs/btrfs/props.c
>> index f9143f7c006d..0dc26a154a98 100644
>> --- a/fs/btrfs/props.c
>> +++ b/fs/btrfs/props.c
>> @@ -10,6 +10,7 @@
>> #include "ctree.h"
>> #include "xattr.h"
>> #include "compression.h"
>> +#include "volumes.h"
>>=20
>> #define BTRFS_PROP_HANDLERS_HT_BITS 8
>> static DEFINE_HASHTABLE(prop_handlers_ht, =
BTRFS_PROP_HANDLERS_HT_BITS);
>> @@ -312,6 +313,39 @@ static const char =
*prop_compression_extract(struct inode *inode)
>> 	return NULL;
>> }
>>=20
>> +static int prop_readmirror_validate(struct inode *inode, const char =
*value,
>> +				    size_t len)
>> +{
>> +	struct btrfs_root *root =3D BTRFS_I(inode)->root;
>> +
>> +	if (root->root_key.objectid !=3D BTRFS_FS_TREE_OBJECTID)
>> +		return -EINVAL;
>> +
>> +	if (!len)
>> +		return 0;
>> +
>> +	return -EINVAL;
>> +}
>> +
>> +static int prop_readmirror_apply(struct inode *inode, const char =
*value,
>> +				 size_t len)
>> +{
>> +	struct btrfs_fs_devices *fs_devices =3D =
btrfs_sb(inode->i_sb)->fs_devices;
>> +
>> +	fs_devices->readmirror_policy =3D BTRFS_READMIRROR_DEFAULT;
>> +
>> +	return 0;
>> +}
>> +
>> +static const char *prop_readmirror_extract(struct inode *inode)
>> +{
>> +	/*
>> +	 * readmirror policy is applied for the whole FS, inheritance is =
not
>> +	 * applicable.
>> +	 */
>=20
> Extract is the 'get' implementation of the property, not inheritance, =
or
> I don't understand what does the comment refer to.


prop_handler::extract() is only used by inherit_props(). Readmirror =
property is for the volume/fsid so prop_handler::inheritable is set to =
0. So inherit_props() doesn=E2=80=99t call extract() for readmirror.
The getxattr still work using the xattr interface and will have to mount =
the root which is I think is ok which is similar to the admin only =
operations, otherwise we have to introduce a new ioctl.

Thanks, Anand


>> +	return NULL;
>=20
> The return value should reflect the status of the property, ie.
> basically the same value that would set the current state.
>=20
>> +}
>> +
>> static struct prop_handler prop_handlers[] =3D {
>> 	{
>> 		.xattr_name =3D XATTR_BTRFS_PREFIX "compression",
>> @@ -320,6 +354,13 @@ static struct prop_handler prop_handlers[] =3D {
>> 		.extract =3D prop_compression_extract,
>> 		.inheritable =3D 1
>> 	},
>> +	{
>> +		.xattr_name =3D XATTR_BTRFS_PREFIX "readmirror",
>> +		.validate =3D prop_readmirror_validate,
>> +		.apply =3D prop_readmirror_apply,
>> +		.extract =3D prop_readmirror_extract,
>> +		.inheritable =3D 0
>> +	},
>> };
>>=20
>> static int inherit_props(struct btrfs_trans_handle *trans,
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index a13ddba1ebc3..d72850ed4f88 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -5490,7 +5490,14 @@ static int find_live_mirror(struct =
btrfs_fs_info *fs_info,
>> 	else
>> 		num_stripes =3D map->num_stripes;
>>=20
>> -	preferred_mirror =3D first + current->pid % num_stripes;
>> +	switch(fs_info->fs_devices->readmirror_policy) {
>> +	case BTRFS_READMIRROR_DEFAULT:
>> +		/* fall through */
>> +	default:
>> +		/* readmirror as per thread pid */
>> +		preferred_mirror =3D first + current->pid % num_stripes;
>> +		break;
>> +	}
>>=20
>> 	if (dev_replace_is_ongoing &&
>> 	    fs_info->dev_replace.cont_reading_from_srcdev_mode =3D=3D
>> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
>> index 7f6aa1816409..e985d2133c0a 100644
>> --- a/fs/btrfs/volumes.h
>> +++ b/fs/btrfs/volumes.h
>> @@ -219,6 +219,10 @@ BTRFS_DEVICE_GETSET_FUNCS(total_bytes);
>> BTRFS_DEVICE_GETSET_FUNCS(disk_total_bytes);
>> BTRFS_DEVICE_GETSET_FUNCS(bytes_used);
>>=20
>> +enum btrfs_readmirror_policy {
>> +	BTRFS_READMIRROR_DEFAULT,
>> +};
>> +
>> struct btrfs_fs_devices {
>> 	u8 fsid[BTRFS_FSID_SIZE]; /* FS specific uuid */
>> 	u8 metadata_uuid[BTRFS_FSID_SIZE];
>> @@ -269,6 +273,8 @@ struct btrfs_fs_devices {
>> 	struct kobject fsid_kobj;
>> 	struct kobject *device_dir_kobj;
>> 	struct completion kobj_unregister;
>> +
>> +	int readmirror_policy;
>> };
>>=20
>> #define BTRFS_BIO_INLINE_CSUM_SIZE	64
>> --=20
>> 2.20.1 (Apple Git-117)

