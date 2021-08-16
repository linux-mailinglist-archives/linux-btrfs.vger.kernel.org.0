Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 634653ECE79
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Aug 2021 08:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233390AbhHPGLM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Aug 2021 02:11:12 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:31790 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233444AbhHPGLM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Aug 2021 02:11:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1629094241; x=1660630241;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=0INljrSybkZmERzMhceVo4U8OXEYT044yHMYB7cZQ0c=;
  b=gs8lfE3V64//w/b7/TvWgMQBksDSivhOBjMe6sdRFoV0kzgiz0L+SIac
   MRTtAc65H4+x/G2rZW+tVLnJYZ0fntrMVRjynEp+Tbxd8FyDDenmZxIO6
   1pHeHmh+fD8U15GiI4yiU660dRShVDZ+TmGyqTpc6ZJ/FUsqtof1Z8T8g
   GtoY0X3sY51CuWTKc4UNyF/eqHOqVl+bxuOQupWaG/kfjdMwFriGInqOi
   fzPRsis3h7NILmR4Sn3BVAPSqTJaFYyMMZZq0RwvP5lxmBU9/mih+ctyL
   7lkhxzl2VK1AwqQk8LoeKGz5w4XbmZTp4NHYQoMMNURLc5jmeS2AkhLGh
   Q==;
X-IronPort-AV: E=Sophos;i="5.84,324,1620662400"; 
   d="scan'208";a="177915005"
Received: from mail-dm6nam12lp2174.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.174])
  by ob1.hgst.iphmx.com with ESMTP; 16 Aug 2021 14:10:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RQB7+G4U9h1cKevmoIFtuKTPTC3NUd0ZLHdkTY1yKZnL/O2HsbfLWBkAJCJA7OcOSh0iLBU+5Q8rEM6opWYYGycaH5cYs0478+FJNwEHALIYwYw1k2eql40bcbeWVAfWrg1i8MXtbj2vMvFQPUYyBnlaDn0GggpEfggRYXFCZBlk+0J3f/L8pawZpYos+dCCE/w/lCijkQZ9Pnom6M70OiZAtyRCBCouz8cYp848vlIWEyK0mXOtcdxMrVsGx1ht+bR6+HaBQ1CBbPOC0thWaRBJMxEw+MxnKbbShGBooBUcOLYR9snbtZAqcKjPpd8hOriogLkHSnYpCAjez/bO6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8gSQL6OIKe7VtL/cw+lUFqxbwmTrO6QDzHLVHq+jSM8=;
 b=XPBGJd/ygelfkPO0YjsiDGDsdF6CoaMoq09J05nkfbTWvMtbuwPbAnuU8QT3QRb0sQRihNC42TapsrjouX/B92a2/AiOBCR9IzsCrQtUDnq6qgj5NcKr7wLjrN3BULf5C1Xyt4tmc3zWGM/0nws+R4TYMLwca4UHN1jbVCCh+MXB0bQTSN32FHWLVtQaI0Ck2WzAu3zMlHAPcUsIkVNApaGbOOYcmDNt91kfbTZMD+F5JV5B5Rn6P4IwnYwqzb6WO9l+B6Z8uCbxd7reamWtVPorKnkH3G0zXHWhV9XUm8MQuOIz2MtcTktn3xvWx6Nf/ACk1kzNJPlL7FkL8rYTRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8gSQL6OIKe7VtL/cw+lUFqxbwmTrO6QDzHLVHq+jSM8=;
 b=Y1yXDK8r1f1STOnYDsVL5oeKfkyhfScLsre9xuwOI2eUvI1hwYTltHXGjCCr6dwXqdLLWyZxOM1c3r+j3bIdPfoYIeXAEbDklpFi5ynC4MnY332okbgfaJrPBRYY6MYbj3CWpGFXd89l8E2Rflz7bT1Y84kf5Nw5T6US/Y9sso8=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by SJ0PR04MB8276.namprd04.prod.outlook.com (2603:10b6:a03:3f0::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16; Mon, 16 Aug
 2021 06:10:37 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::413e:7e96:6547:b28b]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::413e:7e96:6547:b28b%6]) with mapi id 15.20.4415.023; Mon, 16 Aug 2021
 06:10:37 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     Eryu Guan <guan@eryu.me>
CC:     "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 7/8] fstests: btrfs: add checks for zoned block device
Thread-Topic: [PATCH v2 7/8] fstests: btrfs: add checks for zoned block device
Thread-Index: AQHXjsNj1aHh+umS8k2lIg493iT2QKt0slyAgAD6+YA=
Date:   Mon, 16 Aug 2021 06:10:37 +0000
Message-ID: <20210816061037.wkgnaruphuvjplt5@naota-xeon>
References: <20210811151232.3713733-1-naohiro.aota@wdc.com>
 <20210811151232.3713733-8-naohiro.aota@wdc.com> <YRku1QTvyOYc0AZv@desktop>
In-Reply-To: <YRku1QTvyOYc0AZv@desktop>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: eryu.me; dkim=none (message not signed)
 header.d=none;eryu.me; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f7674998-4019-4581-74f4-08d9607c913c
x-ms-traffictypediagnostic: SJ0PR04MB8276:
x-microsoft-antispam-prvs: <SJ0PR04MB8276A4E206D9033E2BF174048CFD9@SJ0PR04MB8276.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FXqqFIi20Eb8dmyoLGp+vWYXTHh8JOGSOPWmdIgC1L4+H4eiae7PvtyxY8bzAGo18JvGdFJ62S1NUHIFng7FZi9opU6n5bKwG9SSaKnyi9P4fW7+820tyIKeAgj29w1JGkI9yPHvc/oVWdoW458WddhU8O+9C/U2H5p5vOrep/JYxY0mk1vsvmAqDQYxZcXaS1WZDjZYSegRlg4Wc9aujH9HVK19ukaq+fPPP8kuPr7XRedKCesgYgz/noH9g2L14jFnihIkWeJ2LKD1X7uhyCIsLDq7xK587z/2o4Wlil90A9/O/W04aNN2Lu+BqBn88ZzazvEB0dkLK8Vj8IEcX9AdajiG082seXV08g+12N0Z7yUo2wlFvwhU2J6Js0mkyph5kpPQDF4RzuxjSKop9YZx+v7jLOCGfxpDxYlj/Mq12QZdi+YxH/dkLisKF03QBw0gcV36MvkuuCIFzfvTBGZ2H3LIDpSBxvQlTEVwP02cND1McM5oBWkl3w8cBEIY/8dkD3hNdv1I1U7dlBjgw/9FBkRs3GIAnd4CHtCec/ma0Ywa2fa/sVBB5EaR3ymlSy/m29+QqhYDeVjmMAnhVsMOHkPNe5O8pOyw5dsZl21JIbhWzSLVhNgTYKBlcs0uPuLJ2iKx53kibDCFUXXKvTpL3ZmxjMG0yOqX8NqAKWFjrf79I+tAeEJJlw+DVxsgXiYMi4cu9hfSZFvCy1oAxQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(39860400002)(136003)(376002)(396003)(346002)(366004)(9686003)(6512007)(1076003)(83380400001)(316002)(54906003)(5660300002)(478600001)(26005)(86362001)(71200400001)(38100700002)(91956017)(76116006)(66476007)(66446008)(66556008)(6916009)(66946007)(6506007)(8936002)(33716001)(64756008)(38070700005)(122000001)(6486002)(2906002)(4326008)(186003)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hMbyUg0PltF364yUwlJU/zDs3pjNyVHWUgvvVkTNyMPcgVqyK9lcBP9gr0tk?=
 =?us-ascii?Q?cVZCKgEcSymMYv0vjDRcxpR+nZXL0Dyz+l1TWPZjgkPLDuGVpjcsEun9Io2t?=
 =?us-ascii?Q?iQ/9nVkrc3Rq+s0LbALnkkQP0ZPUJYV77+GVxke+WIpAIhqD0EIIEpGhr8PN?=
 =?us-ascii?Q?lrwr+ylEq+WBON1/2a1VZHBT9SzgDWXJtbwfzkBqlM9ipax5rtZZmXNjtgUq?=
 =?us-ascii?Q?2jq80XC0AuA35HQGfWsDzFt7wOMKYIhTZJCJzY4FP1tBMS1uKu9uq992q1cj?=
 =?us-ascii?Q?50JdC05SU5amP2Ouhi6oviyARKHztwFsRVZPUjVUKO1drobb9bIEljiwpFzB?=
 =?us-ascii?Q?RvsI1fKD7lyVbjpCsWKM/JxiVpq/wOz2HU/yza0/M3TwMPPWWkKM5StWSCBY?=
 =?us-ascii?Q?wbcYUtFTt7+C5LJykZyB8DFgEl4ZjANEJgTwmL7eDoo44TO909/o3izXQFUe?=
 =?us-ascii?Q?KeMIKq00ln7IynuOemPv7Xd9C/+J6G29uqMpgDaplHswkqgmURHRdaSdnt1Z?=
 =?us-ascii?Q?xezyC4N/BzfR14rx903B8zI9MPmMRSpOFKWZBkamg0W/hehpStBXaa1CHebi?=
 =?us-ascii?Q?54xmKCdOiVsAIN/eVLxe2SzbCsET6ufr3UeLlDj9+ESCdxuarLJdg/q3uFE7?=
 =?us-ascii?Q?Nqm31CH51i7a1zOTRjCorWTOzDooFAi7nSx4dJEiOqsctVacIy2JLROn9EGI?=
 =?us-ascii?Q?gIiJmWNAXykLrF548ELH1lFtnil1CYvHUz3O5+D4ewlQ88h+EsgUBuuySo64?=
 =?us-ascii?Q?uG+ork/Zq5/BSFwskBb9c3SUB+BgoCTQijjVld3QcOEqSKqUKc8rMNBqsj1C?=
 =?us-ascii?Q?uj4uaJARAwPRY7/N52MwjGvPVgIIWlHuSSPotkqebLKMiwsKlcrm7wb4Xbgs?=
 =?us-ascii?Q?bHGjiNtpSdvuHgAQOfwBkIz3izkfC0jHVhhzFMQ3BzNrl7x7urTn9QH7wX6V?=
 =?us-ascii?Q?47X02VcidtDKfKqlnd98Z+rNAxAiM062VIRyiSfyiCZjHre+v2qvLUMnAI64?=
 =?us-ascii?Q?7JAXAT15DgybwE5vVhUCXpw3K4O8ExkP8vGSbxpuq7iqVhp2phc0WwjWXU9E?=
 =?us-ascii?Q?gDoIlREU7nlBuumRgZbPAoTF6YToBWaSu6aRS7WH2i+UAfOtFvTr6obAX2Nz?=
 =?us-ascii?Q?neMg7eUh0Exvg7hnofYPZulUB4uJJPMLiAycocTGjaL3ppCV+xpFeYZSbYY3?=
 =?us-ascii?Q?Xhi251YgNmht+CFqPJspfH82mWmxtymYQI4oQkK1VymTGZU7E84Dz2gZGd9d?=
 =?us-ascii?Q?SqHGiyyzieMpPKkZeHVyP8Bwd7J5l+B3zplJCU2gN+I99pUNvoTSMlSg1Bw+?=
 =?us-ascii?Q?EUfnaX7uxCs2n6OTLqSSdOMtMF1yWRSlwfI8lPTG60LCHQ=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <80DB407E863A704C9313C36DB548EB21@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7674998-4019-4581-74f4-08d9607c913c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2021 06:10:37.6842
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wLCzY0xJMwdOlFrXkLgRsuH4lhYl5WOJIJzi1vutckcaaZYG7/71fxyCWEziQPe7kIHdA/0Ct+UiI0k9OKxd4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB8276
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Aug 15, 2021 at 11:12:21PM +0800, Eryu Guan wrote:
> On Thu, Aug 12, 2021 at 12:12:31AM +0900, Naohiro Aota wrote:
> > Modify btrfs tests to require non-zoned block device or limit some part=
 of
> > tests not to be run on zone block devices.
> >=20
> > Modified tests by the reasons:
> >=20
> > * Mixed BG
> >   - btrfs/011
> > * Non-single profile
> >   - btrfs/003
> >   - btrfs/011
> >   - btrfs/023
> >   - btrfs/124
> >   - btrfs/125
> >   - btrfs/148
> >   - btrfs/157
> >   - btrfs/158
> >   - btrfs/195
> >   - btrfs/197
> >   - btrfs/198
> > * Convert from ext4
> >   - btrfs/012
> >   - btrfs/136
> > * nodatacow
> >   - btrfs/236
> > * inode cache
> >   - btrfs/049
> > * space cache (v1)
> >   - btrfs/131
> > * write outside of FS code
> >   - btrfs/116
> >   - btrfs/140
> >   - btrfs/215
> > * verbose output
> >   - btrfs/194
> >=20
> > Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> > ---
> >  common/btrfs    | 18 ++++++++++++++++++
> >  tests/btrfs/003 | 13 +++++++++----
> >  tests/btrfs/011 | 21 ++++++++++++---------
> >  tests/btrfs/012 |  2 ++
> >  tests/btrfs/023 |  2 ++
> >  tests/btrfs/049 |  2 ++
> >  tests/btrfs/116 |  2 ++
> >  tests/btrfs/124 |  4 ++++
> >  tests/btrfs/125 |  2 ++
> >  tests/btrfs/131 |  2 ++
> >  tests/btrfs/136 |  2 ++
> >  tests/btrfs/140 |  2 ++
> >  tests/btrfs/148 |  2 ++
> >  tests/btrfs/157 |  2 ++
> >  tests/btrfs/158 |  2 ++
> >  tests/btrfs/194 |  2 +-
> >  tests/btrfs/195 |  8 ++++++++
> >  tests/btrfs/197 |  1 +
> >  tests/btrfs/198 |  1 +
> >  tests/btrfs/215 |  1 +
> >  tests/btrfs/236 | 33 ++++++++++++++++++++-------------
> >  21 files changed, 97 insertions(+), 27 deletions(-)
> >=20
> > diff --git a/common/btrfs b/common/btrfs
> > index ebe6ce269a6b..fb1a65842012 100644
> > --- a/common/btrfs
> > +++ b/common/btrfs
> > @@ -222,6 +222,18 @@ _btrfs_get_profile_configs()
> >  		else
> >  			local unsupported=3D()
> >  		fi
> > +
> > +		if [ `_zone_type $TEST_DEV` !=3D "none" ]; then
>=20
> Better to have some comments in code as well.

Sure. I'll add comments for all the places.

> > +			unsupported+=3D(
> > +				"dup"
> > +				"raid0"
> > +				"raid1"
> > +				"raid10"
> > +				"raid5"
> > +				"raid6"
> > +			)
> > +		fi
> > +
> >  		for unsupp in "${unsupported[@]}"; do
> >  			if [ "${profiles[0]}" =3D=3D "$unsupp" -o "${profiles[1]}" =3D=3D "=
$unsupp" ]; then
> >  			     if [ -z "$BTRFS_PROFILE_CONFIGS" ]; then
> > @@ -419,3 +431,9 @@ _btrfs_rescan_devices()
> >  {
> >  	$BTRFS_UTIL_PROG device scan &> /dev/null
> >  }
> > +
> > +_scratch_btrfs_is_zoned()
> > +{
> > +	[ `_zone_type ${SCRATCH_DEV}` !=3D "none" ] && return 0
> > +	return 1
> > +}
> > diff --git a/tests/btrfs/003 b/tests/btrfs/003
> > index d241ec6e9fdd..af0dc8a7e105 100755
> > --- a/tests/btrfs/003
> > +++ b/tests/btrfs/003
> > @@ -173,12 +173,17 @@ _test_remove()
> >  	_scratch_unmount
> >  }
> > =20
> > -_test_raid0
> > -_test_raid1
> > -_test_raid10
> > +if ! _scratch_btrfs_is_zoned; then
> > +	_test_raid0
> > +	_test_raid1
> > +	_test_raid10
> > +fi
> > +
> >  _test_single
> >  _test_add
> > -_test_replace
> > +if ! _scratch_btrfs_is_zoned; then
>=20
> Same here, some comments to explain why replace doesn't work with zoned
> devices?
>=20
> > +	_test_replace
> > +fi
> >  _test_remove
> > =20
> >  echo "Silence is golden"
> > diff --git a/tests/btrfs/011 b/tests/btrfs/011
> > index f5d865ab3d21..b4673341c24b 100755
> > --- a/tests/btrfs/011
> > +++ b/tests/btrfs/011
> > @@ -226,15 +226,18 @@ btrfs_replace_test()
> >  }
> > =20
> >  workout "-m single -d single" 1 no 64
> > -workout "-m single -d single -M" 1 no 64
> > -workout "-m dup -d single" 1 no 64
> > -workout "-m dup -d single" 1 cancel 1024
> > -workout "-m dup -d dup -M" 1 no 64
> > -workout "-m raid0 -d raid0" 2 no 64
> > -workout "-m raid1 -d raid1" 2 no 2048
> > -workout "-m raid5 -d raid5" 2 no 64
> > -workout "-m raid6 -d raid6" 3 no 64
> > -workout "-m raid10 -d raid10" 4 no 64
> > +# Mixed BG & RAID/DUP profiles are not supported on zoned btrfs
> > +if ! _scratch_btrfs_is_zoned; then
> > +	workout "-m dup -d single" 1 no 64
> > +	workout "-m dup -d single" 1 cancel 1024
> > +	workout "-m raid0 -d raid0" 2 no 64
> > +	workout "-m raid1 -d raid1" 2 no 2048
> > +	workout "-m raid10 -d raid10" 4 no 64
> > +	workout "-m single -d single -M" 1 no 64
> > +	workout "-m dup -d dup -M" 1 no 64
> > +	workout "-m raid5 -d raid5" 2 no 64
> > +	workout "-m raid6 -d raid6" 3 no 64
> > +fi
> > =20
> >  echo "*** done"
> >  status=3D0
> > diff --git a/tests/btrfs/012 b/tests/btrfs/012
> > index 46341e984821..3040a655095c 100755
> > --- a/tests/btrfs/012
> > +++ b/tests/btrfs/012
> > @@ -28,6 +28,8 @@ _require_scratch_nocheck
> >  _require_command "$BTRFS_CONVERT_PROG" btrfs-convert
> >  _require_command "$MKFS_EXT4_PROG" mkfs.ext4
> >  _require_command "$E2FSCK_PROG" e2fsck
> > +# ext4 does not support zoned block device
> > +_require_non_zoned_device "${SCRATCH_DEV}"
> > =20
> >  _require_fs_space $SCRATCH_MNT $(du -s /lib/modules/`uname -r` | ${AWK=
_PROG} '{print $1}')
> > =20
> > diff --git a/tests/btrfs/023 b/tests/btrfs/023
> > index f6c05b121099..49ca95bc9efb 100755
> > --- a/tests/btrfs/023
> > +++ b/tests/btrfs/023
> > @@ -17,6 +17,8 @@ _begin_fstest auto
> >  # real QA test starts here
> >  _supported_fs btrfs
> >  _require_scratch_dev_pool 4
> > +# RAID profiles are not supported on zoned btrfs
> > +_require_non_zoned_device "${SCRATCH_DEV}"
> > =20
> >  create_group_profile()
> >  {
> > diff --git a/tests/btrfs/049 b/tests/btrfs/049
> > index ad4ef122f3c9..a9cd5b2cf12b 100755
> > --- a/tests/btrfs/049
> > +++ b/tests/btrfs/049
> > @@ -27,6 +27,8 @@ _cleanup()
> >  _supported_fs btrfs
> >  _require_scratch
> >  _require_dm_target flakey
> > +# inode cache is not supported on zoned btrfs
> > +_require_non_zoned_device "$SCRATCH_DEV"
> > =20
> >  _scratch_mkfs >> $seqres.full 2>&1
> > =20
> > diff --git a/tests/btrfs/116 b/tests/btrfs/116
> > index 14182e9c0f49..2449e6e3a64d 100755
> > --- a/tests/btrfs/116
> > +++ b/tests/btrfs/116
> > @@ -18,6 +18,8 @@ _begin_fstest auto quick metadata
> >  # real QA test starts here
> >  _supported_fs btrfs
> >  _require_scratch
> > +# Writing non-contiguous data directly to the device
> > +_require_non_zoned_device $SCRATCH_DEV
> > =20
> >  _scratch_mkfs >>$seqres.full 2>&1
> > =20
> > diff --git a/tests/btrfs/124 b/tests/btrfs/124
> > index 3036cbf4a72c..5c05ffae1b8f 100755
> > --- a/tests/btrfs/124
> > +++ b/tests/btrfs/124
> > @@ -49,6 +49,10 @@ _scratch_dev_pool_get 2
> >  dev1=3D`echo $SCRATCH_DEV_POOL | awk '{print $1}'`
> >  dev2=3D`echo $SCRATCH_DEV_POOL | awk '{print $2}'`
> > =20
> > +# RAID1 is not supported on zoned btrfs
> > +_require_non_zoned_device "$dev1"
> > +_require_non_zoned_device "$dev2"
> > +
> >  dev1_sz=3D`blockdev --getsize64 $dev1`
> >  dev2_sz=3D`blockdev --getsize64 $dev2`
> >  # get min of both
> > diff --git a/tests/btrfs/125 b/tests/btrfs/125
> > index e46b194d0139..de6651739f49 100755
> > --- a/tests/btrfs/125
> > +++ b/tests/btrfs/125
> > @@ -43,6 +43,8 @@ _require_scratch_dev_pool 3
> >  _test_unmount
> >  _require_btrfs_forget_or_module_loadable
> >  _require_btrfs_fs_feature raid56
> > +# raid56 is not supported on zoned btrfs
> > +_require_non_zoned_device "${SCRATCH_DEV}"
>=20
> I think this check could be folded into "_require_btrfs_fs_feature raid56=
"

Yeah, that will make the patch much more simple. Thanks.=
