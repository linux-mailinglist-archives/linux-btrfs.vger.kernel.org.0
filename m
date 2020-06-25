Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C269209ACA
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jun 2020 09:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390416AbgFYHsi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 Jun 2020 03:48:38 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:15660 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390237AbgFYHsh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 Jun 2020 03:48:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593071317; x=1624607317;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=ASP0z66O5VkdOGT3xByvwqul/08s53dXMen9xQnFH3A=;
  b=iP8RJ8KL9WZLFaFkGLz+254YNjfviENUD1DEi0iksxOXmSvJh970Om33
   Yr9l3x0vLlveZUJ6ekfoa6peYRqmrrw6RkT9E+y/c4wY7A4FsEQ6kPmOh
   Uciln+vnzN75AUwjGsQA2Im/uve/Vhm906Ol95TxxAR2cb7CDrGUXNYRU
   YOGbeYAWVZH6ZQ4d6b78fMPRkdCwgHQBJCUfiAZzcoYIrTKcnSs1eG04Y
   WLHoYgy1gtocI+WSEpUNHuzI9wS/zPDcNtNvNoeFRKkHp2kDSmLCw/stR
   PR5McPTOZ4TNZQQA4zDUewUHGyGrVV5HP1/1b9s0hCciyWhWQjinSLe0Q
   g==;
IronPort-SDR: MobBYnAhw+9UMhNlqCfGMJ0P5TJWILt6ui2WWSmAEG7sTP9DpWNpCUE42j8LEL1ES0OXwTV+fJ
 cRZA4KSsMHvc+E0ZyTYM4GTESPrD3s8VmftdcLfqhtXeGoKSAiaj9v8tWDHkeVzJGJGM4g23N9
 VUoe4dRPnV6UqtYimmd7bXbkl+3t1JU9UOmDblFHIcxLQpEH8ubLGVb6N2g489jRZ9vyOEnnl2
 P9Lu4mirSfJ+Q0uYEi7aGvWdYB12BWFkMhpeVmvXvWBn6Wg4nHO6VKzu7KlFNXBRFfax9Ks/kt
 fSE=
X-IronPort-AV: E=Sophos;i="5.75,278,1589212800"; 
   d="scan'208";a="250101643"
Received: from mail-bn8nam12lp2169.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.169])
  by ob1.hgst.iphmx.com with ESMTP; 25 Jun 2020 15:48:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U5JxGgUGAicD6Y5Kkmk9//gRTNEzDWyJ75zGxK0UDkgNKWsbbR+17JS8E5BzFy2q88/wC9hzt5Cs6aBZKSXMaiDxN41CztY85AIznraYLUAKrzBxlHffJpgiwYcVP6gER40jyGpAlFquRlwT0SFuATh/Lz1+TBebkgHGmNIMKuGKXXmt+4iE5RFKnIHJfIjl8hEExHG2u9BHzTDZQHBk06rhimbdTcmEc51cfydB81tQiIwiReWdgtl6RZGMybf+d8HaedJuYt4384DGC3EYh42SHU7+ZOWb0FDIOLk2dnOKd8OISsLnD/15jMYEJfye65shvvfqTyjWmyGrvE++tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=REM6Bq0o1TvYhSVW2D4d5cG7mpb094ugx8LFF6ENPCg=;
 b=Kw4QyEUeV6xz700WyYOYwTohB1VWH2dQ1rA/H9Yx8ohKkJhug4hbcp+3WRQSkCIISgxky8u2iOwM2o1+b+CqpUVDPMojgALW78/tWLjaIxH3ZvX1jYGKzasZYBNxP4SiC6CdqFUZ2ej1WTmMbWa7Ru2D0CYkleiW3Wuwis3wlPtbkVXtTBsEXCQFpRocYwiFw/o4+b0LRSP0HCddDDTlriyMCd2ZpWqIp5kGz2j591Rdu5TcmPpbPcGnGeC1mR/onUXVMmqQMBT485jP0/feBC19VgLfQxhS7Zoth8OGwgQ9rKVtN5xHqZTZbyMr6ILiY/BrZtL2qD1oa5SZEAEkjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=REM6Bq0o1TvYhSVW2D4d5cG7mpb094ugx8LFF6ENPCg=;
 b=D6+WcQJge21R23iGzpP+MdEwHSyKg7tzKFaS/Ljt63vnBu3RjQtSs+G7+2RRNybGJ6Jcr6kiDlgd2oDNOBbJ8Ir5pcp8JYF1cV6GiUyPKmVE1RZX3T/kDS2I9wOadczmO0LxBQX8fAMJAU/2WkWKoIqAMmaS6NAf4S/4pa1zUa4=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4317.namprd04.prod.outlook.com
 (2603:10b6:805:2f::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Thu, 25 Jun
 2020 07:48:35 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3131.021; Thu, 25 Jun 2020
 07:48:35 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>,
        kernel test robot <lkp@intel.com>
CC:     "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: pass checksum type via BTRFS_IOC_FS_INFO ioctl
Thread-Topic: [PATCH] btrfs: pass checksum type via BTRFS_IOC_FS_INFO ioctl
Thread-Index: AQHWShFCK43KMhBSekKBmLU/7X0PZA==
Date:   Thu, 25 Jun 2020 07:48:35 +0000
Message-ID: <SN4PR0401MB3598FB358A5EF60D4F0EF5E29B920@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200624102136.12495-1-johannes.thumshirn@wdc.com>
 <202006242200.sloaHMOL%lkp@intel.com> <20200624154006.GS27795@twin.jikos.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1515:bd01:7422:e91d:655d:8b17]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ce32efe1-4995-4848-fa0b-08d818dc2a93
x-ms-traffictypediagnostic: SN6PR04MB4317:
x-microsoft-antispam-prvs: <SN6PR04MB4317814FF585C68281D4D3809B920@SN6PR04MB4317.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0445A82F82
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rR6ITb6pgu7AEkr6Mr499PU1CJ4/uZa/UpWF51+fRASUUjFaLwTKiwNMK/tsEGWJ4Z+8MkyULDi+TxLwkJ/SMn51BugqKzboEfmILOC7VCNotjgNNrf80KzG2SO42euJ6A3t8gM1OD5itanPVJQnov3kW4wU54ZAKIQxRiS9IbE8BOrPkdFG4hoY+SOJvDS3raBz57MsZcrPFpxIkGxMZrtPEJQXsrZnETZSlFWX0Pf+OWrAgdtEWnTDpnjkYdfZTpd8mK3rGsKAxZJqvz0dSrXxhb8HqJQxy3Mo/A1Cz4FH/9B5kKDH/nKGRRQY/5504gq8eA01CT2i804SLofQRg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(376002)(396003)(346002)(366004)(39860400002)(52536014)(53546011)(6506007)(86362001)(5660300002)(4744005)(55016002)(9686003)(64756008)(66946007)(8936002)(8676002)(76116006)(66556008)(66446008)(66476007)(91956017)(71200400001)(110136005)(54906003)(316002)(33656002)(4326008)(2906002)(478600001)(83380400001)(7696005)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 31VHooOjrtX5FNKU8NzY3uH9q3SkPrKVdipHRAuylBimZagTS1ViNhGHppgpN5najKMNtwYfU5oY8QS1ft3++4+2jE6f3faE7HrfnIY8Kuzbl4WBKz1ilubis1J4a2DaydpYtzEu0H3Upz6hg0xih2diXPbeclnAFUxVICuIrmFjfiScADs0ZKqn8MtUOnzJ3wlhSa51xQFsLs751c7kOB0okBGzeCeDq/VrUY4VX8a875gmGMddPnYl0P3/Cv2bD2277ZkJSOKJCDPTnHSMl+XBanXHidPRpC7okox7VadPMOe7P/cIgF9MRKoeWKOFHBj/L8DZr/FOvE+6p+vNqVgzyxuzqdy+s1LpZw4YyhYVomDbHbMls/otNnzkHLoOpPaycIZxDeJ45fTDDWQeQKPMoMoyWk0JfyhEXdCB299IObeiEvOAIaC7O/il06qQDTNWhNfhgqVQlLN+0G4Vj5sXSkVC8e3vCQD4BFgcBMx2qsBnIbrT5o1dLd5SMEJ50arj5Rmx+V5eMk2STWx1u8zrl/6Sp1QtcPWmEAmv/5prSK8uaPkzQ/BBgkgYfyX7
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce32efe1-4995-4848-fa0b-08d818dc2a93
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2020 07:48:35.7918
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ErUn+pVFcBuso0Cdd1uO31I27GRWUMCm8uyeyoWsHdajtF5kicgmjSgh2OKiJh3/p5oWLOqz/hsHq/lKKDqoUVrXoFVvMtzADvCoIM+DgxA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4317
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 24/06/2020 17:40, David Sterba wrote:=0A=
> On Wed, Jun 24, 2020 at 10:15:20PM +0800, kernel test robot wrote:=0A=
>>    fs/btrfs/ioctl.c:1715:17: sparse: sparse: incompatible types in compa=
rison expression (different address spaces):=0A=
>>    fs/btrfs/ioctl.c:1715:17: sparse:    struct rcu_string [noderef] <asn=
:4> *=0A=
>>    fs/btrfs/ioctl.c:1715:17: sparse:    struct rcu_string *=0A=
>>>> fs/btrfs/ioctl.c:3221:25: sparse: sparse: cast to restricted __le16=0A=
>>    fs/btrfs/ioctl.c:3260:40: sparse: sparse: incompatible types in compa=
rison expression (different address spaces):=0A=
>>    fs/btrfs/ioctl.c:3260:40: sparse:    struct rcu_string [noderef] <asn=
:4> *=0A=
>>    fs/btrfs/ioctl.c:3260:40: sparse:    struct rcu_string *=0A=
>>=0A=
>>   3220		fi_args->csum_type =3D=0A=
>>> 3221				le16_to_cpu(btrfs_super_csum_type(fs_info->super_copy));=0A=
> =0A=
> The report is valid, btrfs_super_csum_type returns the data in CPU byte=
=0A=
> order.=0A=
> =0A=
=0A=
Yeah, already fixed locally.=0A=
