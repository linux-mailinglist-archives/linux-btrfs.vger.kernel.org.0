Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91A2836536A
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Apr 2021 09:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbhDTHmG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Apr 2021 03:42:06 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:53726 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbhDTHmF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Apr 2021 03:42:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1618904494; x=1650440494;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=GiBGOamtMh723bNcUAlUQF/Kbdmfluhg80m0c7mk8GA=;
  b=SmIO2ypBigN30vZrUDIPIGf6SSowdyN2EEiPtQ1EkBdpjJuGOLAX4ekF
   Ak8k+1S7o9ncR4bDvVF+tvjTJ6Xcq1tUgkt9bY2Vrn5RDT/Ve7f66WyBh
   r231rQpLCAX6+9oSvIIx3cYRiK8pGg6p6z6VgqJNUMavmfGAHkxUdrxPG
   cPiUfQCEZBGDayvNoMcg9jr2UujKb8dKqNxTUjsltWNWKzKcweTF+3XEy
   A4cse+ZfbMsi7FR3OhjFTgSliwZnBUUl2iE3EB6Oy67/41VeaFoW+sxQG
   HosNHwSr0zQxaFgAzW3qkk4Er5j086i8ZE9vbs6HldpUkSFqdD+AlaSwO
   Q==;
IronPort-SDR: KuwLWmUUvaKSJ9ESaqJZagf7kDuQGtMHKr4mVV6zLx2PK5JU8vvr3kvDzlFjui1ZOEYmkOx5gr
 Y8OxfWKd9f5+/FTK7RPxBwUM3SV+HC40hoXh0CRogaAhyacZ/4TRx0J+iW0KUuYv6WncIHnlAO
 O+H8NxT4a3AcVao0M5yOGP3tbhaMN5KU/VmpwezgOvlDy23EKR3iU0H/jO3IL1XNX9bkX98vYv
 Wo2et8PxoDf2bgevOrbMqTd68eNgGyWaOjkqbvFEIdxGvyK0O+C0ayFQu6O0EjeJpphWMHMZkP
 2QY=
X-IronPort-AV: E=Sophos;i="5.82,236,1613404800"; 
   d="scan'208";a="276465449"
Received: from mail-bn7nam10lp2109.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.109])
  by ob1.hgst.iphmx.com with ESMTP; 20 Apr 2021 15:41:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MPoXaJQdeqdIkOMnC/lHz31Dxy6v465TKxJt0xs5mapjfXrEj0R/YX72QLeTGYC3djEYkfQGutTO+Gky8uPCU38ZM9POQyxQl8z2vIRWAN9/CnkwspWH+DHw2j+tkz1+AaMJwo+FpV9VgNKnXbiAnRVqxaVMKP7t4hscxsTLMdcu/6rlP/bxbZDKEQSBX75k2Eay2aS99sNn1dd9ywutkMOAY7TVJBndYBwRv67XbBXX/GZBl5L10gYIp7WKi1Ra82gwttP4oUAR095OT9xSmXsM5957jNqe8CSY6g2QC0/vl7U9iqlf4OQDQEPPo/p3ZlCkDpUJCvYaipBcNWanng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kDegWpWKV/uidkISl6WexLul+IQetP7V0SMVDs02mRI=;
 b=nUAv3fAnYpUC/emGb7lL4GmWEy32D59x5CMFtBQ+Jksk3i/foubjRX7EM3vq+ajcyTSw3pRapaNDJ3c2qaspRIKvI5V8NLjFGVWC2Fa/HH8ZYWCw1xP/J0ebvgo1VJ0Z770TTZT6zhQMVqSbis2oiz83TXiXEuuTqBA0xQtD7GpFDphmSGecrXoCKlxRUJcZQdyIzKgoMDUacjdUgzwFEFYYSr7p6RsdBTdUGZnOEhIQY2FDEU0aYnvxv7F37uX2C4HTR9bmVK/3Nb+Evl2t4K5GPzd8I+0rDWq3a7j7RptUX3hokqohvabDTfQ06g7q2eIhqFd8xSUinV7a1iSv7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kDegWpWKV/uidkISl6WexLul+IQetP7V0SMVDs02mRI=;
 b=ggAOYNCI0Crxp0o/QD32bGTGHWjCRfdtOQa7hQFgncr3PmLk+JUHXsSeAeWpJgXtxRnjGT8yS0KaJP50a7NnoGNw0GDQaWIHQXGX7tqo+dYWzwzi56LPstaZzHcphv6gAzVKZKYSF+SfgG8GxCDO9zfSPzy5P2JLSDggqH4FZ5I=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7190.namprd04.prod.outlook.com (2603:10b6:510:1f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.19; Tue, 20 Apr
 2021 07:41:32 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3%4]) with mapi id 15.20.4042.024; Tue, 20 Apr 2021
 07:41:32 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>
CC:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Filipe Manana <fdmanana@suse.com>,
        Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH v5 3/3] btrfs: zoned: automatically reclaim zones
Thread-Topic: [PATCH v5 3/3] btrfs: zoned: automatically reclaim zones
Thread-Index: AQHXNO9jw16khJCmGkevzXaXiVgdNA==
Date:   Tue, 20 Apr 2021 07:41:32 +0000
Message-ID: <PH0PR04MB7416F1087888F5E1452765C49B489@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1618817864.git.johannes.thumshirn@wdc.com>
 <f4548d6db76cb1168266d1a216563441308b615b.1618817864.git.johannes.thumshirn@wdc.com>
 <20210419171809.GQ7604@twin.jikos.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1460:8801:8d26:331c:72e:ec33]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4866e7b0-2b55-4b3f-12f4-08d903cfb7be
x-ms-traffictypediagnostic: PH0PR04MB7190:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB719056B4D41F58462E29AE549B489@PH0PR04MB7190.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VtTLc7lM/2PmO7ktH9FNX3cKLvZxiSAqP6QhmotoDqYnsp4ph/11k8UQHzRNgNPnaxqnk9FDiVl53QKXgwGW5k0A8WmW0rtfDle1AB8VlfvJVX6aQKJAjI7zZgtZ1Ud7xq7TfPHBPzoX0A7fdnUmm73eNYqdyTRFkCIeGYrmI5NlMGgF7HvyqZZpqxT6XwJNzplV64k4fcE4iqbbgF9ZkTuokJ6PzRuJDHRGguFH4dXGv5eTwyZz0z1Lb9kXP7YP1rNn3Ksyv7Qy5T9e4zTkBTqSoh+svycuVGwJi+wn85cpau2qnJAtbP466KdENGbHi2YLzVzgM3jXrFOQ5c4qDqRBT4iIzhgFOLCWFXx3yiSxUMBOod7YwrBz9TwCTDky7KqzlfqNGOwAz4gzJ1+8BD80FN/wM5yvAvlr2lMCOcngIXNvmkCZ5bNadZlt4hoHz/N84K2p3PhSOKqDCHKmsPaqR+5qtlZjfkJVtNKUSdS0/I8ff/yNK9pc46m019D2rw1vKZabSpNcmonfy/DAiJspuMZbQvY9fFf+sMoPS45FDFxb3MVszr+lFvUGkGOFa8uq6EIzBttcIqCfOuEsUVLtYFXz+zCZFIs8oYEOA4w=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(376002)(136003)(396003)(366004)(52536014)(122000001)(5660300002)(71200400001)(33656002)(91956017)(55016002)(76116006)(66446008)(38100700002)(6506007)(86362001)(7696005)(66946007)(4326008)(83380400001)(64756008)(66476007)(8936002)(66556008)(9686003)(53546011)(478600001)(2906002)(316002)(186003)(54906003)(6916009)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?TAQBKOXtOLmiu4/PPCsQPdqVnu7L1L+/MO9qUNEs9JdcbUWg1aakUVmMHnjd?=
 =?us-ascii?Q?KQXeO3d6mpwPEV54zAMeF+jYlH2WKtSjnMwBMTiyxOxEb9Eb8WAyhS/cpoEW?=
 =?us-ascii?Q?Ap9JYgPtrG6kaVB9siBS2U0R8iA3dwDJN4pFXO5LuSMq/p5zH8AooYQ6DBtN?=
 =?us-ascii?Q?r0KCAOK5OUWDwA6tVy7+x6ejeLis6BW8YKQ6FE5J1pTnfD5xk/TSQDZ1uyOL?=
 =?us-ascii?Q?tjmNUjolBv2PEBGd4LXqHdNJrZvSnBsPMYN+uBbYVNsw0vEuxoHdsI5g9g/4?=
 =?us-ascii?Q?2siCSmik6kEUKbInpZ1gReB0GhhccN8eO4SZhWJnZAJamczfkDCBoTbOwOHR?=
 =?us-ascii?Q?bD7LOOjLDLjADQCgc3qa9TlGEWEaCTyCXLU7QjnQ6L1AwJf6LOT2rUJ9KKh5?=
 =?us-ascii?Q?Gspz2O5s+Np8WI97RSOPDXpU92bqtpNl+LBeBDP9OI4oqZs47tZ0bhw+vzny?=
 =?us-ascii?Q?R4MMAzIjuTCrexo3PSZ0fQB+QtdkQ/f47FEwONr7MsZ/ibYeoI+BXZErRWfC?=
 =?us-ascii?Q?tP1fWN+bzj3Jdtb2SkFzFFPHjUdwzE6OHN2rHyOLHheTFcLlox/iN/phNtjf?=
 =?us-ascii?Q?dToGq4BobOD8KbQOfdVfkC1zsgVW4fCJqD0QtZs3DbTA2ao8ksXAXJyE8USW?=
 =?us-ascii?Q?GcxAkw6HP9J/AiFxWjKmu7uK/MZ7N/HV4w2kknfFK9oh2J09r+CpAtWAy9dP?=
 =?us-ascii?Q?EJmQeYxNhbOrg801WKpsTwjU/rXYSRrDK8aO3cmWm3pPdhLU6WrnUtcmGB1G?=
 =?us-ascii?Q?6eVOw+QwTuiIZfoUeUGl9KskKRLRb39vsXqxnhpf+caHpdWdGO6inhN7BsrD?=
 =?us-ascii?Q?dN3a0CHYYHp6+YPTrUaG5mRDVwZB1kH9QuhV3LNOD94vKQelhDcm19Lqr9w8?=
 =?us-ascii?Q?EQdmrA5Oq0onJZypvfNGKUB01F/RfLPCvldg8ZPG/pcPu/HQ/fh44fVDcbnb?=
 =?us-ascii?Q?tjWZ1aw0CIv2hY9W59XqlSaUnml116Xoxt7wTvY9iP4TC8Xeig2RV7riqlHV?=
 =?us-ascii?Q?Kxdv4P7/YiYnHvgqs1y0UIlmwfzUQqFy7uLm4nDLS0I8uBkIx9LcZSeX2zDx?=
 =?us-ascii?Q?g6lnIdmcQUdgIl4/9JKJPNk7G/+2+RxWnCt6c2mqxtox63Yp1tZtn/5fDQ/Z?=
 =?us-ascii?Q?ABVRUmOZ8MxR/714xvhveb6bnrNrPNOoVhqlF6RI7LiMVPFiOvwRn1CLX+7s?=
 =?us-ascii?Q?kkbQRW2sBpTMT/RaWpUXteXVaH6gBO2+A75JzGLWXPjxi5dChYbz1X2oTXEa?=
 =?us-ascii?Q?FU3a55uIASlXmApVJaIrev9I4sVR2Nprh0wpO8PdqUQtv43TJWiGi0VL3t6D?=
 =?us-ascii?Q?R3yjhkSfclV1DmSGclVpPKkVd6Bfzo+3A3Ssgu3YE8P8DOolsKEMz0KYMKXM?=
 =?us-ascii?Q?jc5raPYkNaXl8W7rNQnLudWyGwrM?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4866e7b0-2b55-4b3f-12f4-08d903cfb7be
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2021 07:41:32.4042
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CQJy/F7T4Yoq5XmihFbuLTK8vblup3tJj6vAzllybBPVqM81LXs6uO0LMv5781yOGVtPdSyDShaY1O2j/1BI4Iztn5gJRZo7EKlQ/tnfjiI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7190
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 19/04/2021 19:20, David Sterba wrote:=0A=
> On Mon, Apr 19, 2021 at 04:41:02PM +0900, Johannes Thumshirn wrote:=0A=
>> +void btrfs_reclaim_bgs_work(struct work_struct *work)=0A=
>> +{=0A=
>> +	struct btrfs_fs_info *fs_info =3D=0A=
>> +		container_of(work, struct btrfs_fs_info, reclaim_bgs_work);=0A=
>> +	struct btrfs_block_group *bg;=0A=
>> +	struct btrfs_space_info *space_info;=0A=
>> +	int ret;=0A=
>> +=0A=
>> +	if (!test_bit(BTRFS_FS_OPEN, &fs_info->flags))=0A=
>> +		return;=0A=
>> +=0A=
>> +	if (!btrfs_exclop_start(fs_info, BTRFS_EXCLOP_BALANCE))=0A=
>> +		return;=0A=
>> +=0A=
>> +	mutex_lock(&fs_info->reclaim_bgs_lock);=0A=
>> +	spin_lock(&fs_info->unused_bgs_lock);=0A=
>> +	while (!list_empty(&fs_info->reclaim_bgs)) {=0A=
>> +		bg =3D list_first_entry(&fs_info->reclaim_bgs,=0A=
>> +				      struct btrfs_block_group,=0A=
>> +				      bg_list);=0A=
>> +		list_del_init(&bg->bg_list);=0A=
>> +=0A=
>> +		space_info =3D bg->space_info;=0A=
>> +		spin_unlock(&fs_info->unused_bgs_lock);=0A=
>> +=0A=
>> +		/* Don't want to race with allocators so take the groups_sem */=0A=
>> +		down_write(&space_info->groups_sem);=0A=
>> +=0A=
>> +		spin_lock(&bg->lock);=0A=
>> +		if (bg->reserved || bg->pinned || bg->ro) {=0A=
>> +			/*=0A=
>> +			 * We want to bail if we made new allocations or have=0A=
>> +			 * outstanding allocations in this block group.  We do=0A=
>> +			 * the ro check in case balance is currently acting on=0A=
>> +			 * this block group.=0A=
>> +			 */=0A=
>> +			spin_unlock(&bg->lock);=0A=
>> +			up_write(&space_info->groups_sem);=0A=
>> +			goto next;=0A=
>> +		}=0A=
>> +		spin_unlock(&bg->lock);=0A=
>> +=0A=
>> +		/* Get out fast, in case we're unmounting the FS. */=0A=
>> +		if (btrfs_fs_closing(fs_info)) {=0A=
>> +			up_write(&space_info->groups_sem);=0A=
>> +			goto next;=0A=
>> +		}=0A=
>> +=0A=
>> +		ret =3D inc_block_group_ro(bg, 0);=0A=
>> +		up_write(&space_info->groups_sem);=0A=
>> +		if (ret < 0)=0A=
>> +			goto next;=0A=
>> +=0A=
>> +		btrfs_info(fs_info, "reclaiming chunk %llu", bg->start);=0A=
> =0A=
> This could state the bg usage ratio, bg->used / bg->length .=0A=
=0A=
OK, will do.=0A=
