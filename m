Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D516614DE81
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jan 2020 17:09:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbgA3QJw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Jan 2020 11:09:52 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:36586 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbgA3QJw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Jan 2020 11:09:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1580400591; x=1611936591;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=lL8gsbvRGuvTbhffLqLIsSzGRPfba/ZBOEjFZ9I8JrM=;
  b=mZtinIcQajE7LIsfaVXdY4JogzBHwPimziYqYJZlyLHvDTHrir6aBpDg
   +sUJBeSsUoqL0K6BKImVcyjYId6iHpJZWd80GzgtmSEG6DSJOProkeB+e
   X4TevZNNY5SaXUHJefy7yQ+/TbPNAKjykvexl/jg4e9uZjOHHhVrnCq8G
   TSsEM4BFeHa1+YWRF+PtgkhapiazM8FZKzC21smTM9fRN/1FAD3QtQMqU
   DZd2negI/lqPfoX15tdHGua6mqQm5cIsYeyceBIOrw2tf5xC/C8v4LOfL
   Rc0ubPuiWlk6rKsg3Namua/kwBsseI1QXkymI2+Mt0F+LXzmDKx8nMPUZ
   A==;
IronPort-SDR: AaAViAekCosdAOZ9OXPsP9ZNhKunepDw7d6tQTX/WpUC7GmPdVWG1COdtE0M0fDFGnofaQBlye
 WI6xvzh9kkrqRPfPoJlnYcIXQ9tnBSSZAflzduezvSJPGw3B2SPBO6IWoBzKCnd4/NcjV9hMbX
 qtQ4aSzOiOM0N20HYWeL392v2a6/e1jAwpp0/BZbLRE/BvcWECCWMOoJvci1I7KlSTxKFtuyEW
 iGWRvAPvHnFI20fe+3ThSLa9UQL/YRHtzsZditst/c+eF1kt8E901BWVfpvhHdZ0mpfXNrmNME
 /YY=
X-IronPort-AV: E=Sophos;i="5.70,382,1574092800"; 
   d="scan'208";a="128754243"
Received: from mail-mw2nam10lp2104.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.104])
  by ob1.hgst.iphmx.com with ESMTP; 31 Jan 2020 00:09:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AyD45qfssLcH9H/QW6F64Nci5X81apdeJW/tV0M9/mdB3RJmnyGErEeACZ05jSp2X0LEq2GJUZD7u+ujVkGHj/7Y1+gazTisyONARLCvEToOu+Cnx52ZbWv1Vw3X4n2Q4rFzaKKDbNB8FcK3jZAMiT4OoX9WH3O99KF0RvTrW3MR+KH2UpVcAE0PGxwYaOuTZQFTizBO+MDvsxLBZHWxQT704tsXJSoPfvS4QRITThsDf9gbGwDgFQ+002YbL0fOfB0mXdXq3aqboWPkE4ELG8MdnaoyfI/XVTEgXCwMyQNzRnyDI2fTgSSWLWX8FRNRgYJD2CXt1dXR/JUp/uVLQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x1DTeNxeUwG30glCwINN/1nneoQSKZxV1LZ0STY5sH8=;
 b=cT7I0+4Mpia+NOA1cIdw6WZNQRdiHr3Hz+/EWI216yD2umZaZlnnS2UpYPAHwWeXJliM4jcqxGdPzpCEMU7fIsPNlByMbeAe3k2dr5nZh00SJ4aEqAwRMzU3pVxvnIpQQMRGtGA/etU7et1Mza3ss9kBc/rM8nhVDVVgNnGD4XTAhbuHjYEZe1qQNJ8BFdy4hjpcNsGXw9DytciYcP7ZeHKyvc43idv61WCMKDaam+ZaIpUFZfSZaaxQyEC4+mpPDcDEUEtvO2Fgjrdqhanv7mPujKEzQGUDFgTVCZzupW9mLFFvqSAj5BVghUyu86ITmvkE1nYFkh+VG6dBXjCwyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x1DTeNxeUwG30glCwINN/1nneoQSKZxV1LZ0STY5sH8=;
 b=e8v0YGBO3vulfcbpRF9SISY12af4o4lgg7v5CPuFyIrCpMFRuAWLBynpDP559FH3QxJ9Lk4bHGT4Uda/TSH/sZj02XXKBHct5jewWr68nQTh1vTu62zCyqtJelN9Kedd9vXFg8aYy2Sxk5m+TyIMK6BJCumM23h+XNH8pfgT0GY=
Received: from DM5PR0401MB3591.namprd04.prod.outlook.com (10.167.109.143) by
 DM5PR0401MB3622.namprd04.prod.outlook.com (10.167.105.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.20; Thu, 30 Jan 2020 16:09:46 +0000
Received: from DM5PR0401MB3591.namprd04.prod.outlook.com
 ([fe80::2481:ca52:b929:3077]) by DM5PR0401MB3591.namprd04.prod.outlook.com
 ([fe80::2481:ca52:b929:3077%5]) with mapi id 15.20.2665.027; Thu, 30 Jan 2020
 16:09:45 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     "dsterba@suse.cz" <dsterba@suse.cz>,
        David Sterba <dsterba@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v3 0/5] btrfs: remove buffer heads form superblock
 handling
Thread-Topic: [PATCH v3 0/5] btrfs: remove buffer heads form superblock
 handling
Thread-Index: AQHV1SrKCplaciq1OEKao1x65qqI1g==
Date:   Thu, 30 Jan 2020 16:09:45 +0000
Message-ID: <DM5PR0401MB3591C0E5FE103FF1142005099B040@DM5PR0401MB3591.namprd04.prod.outlook.com>
References: <20200127155931.10818-1-johannes.thumshirn@wdc.com>
 <20200129142526.GE3929@twin.jikos.cz>
 <SN4PR0401MB359858CB7DFD0082B44D57379B040@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20200130121530.GO3929@twin.jikos.cz> <20200130133921.GA21841@infradead.org>
 <DM5PR0401MB35915F7AE2B1A679213ED4AD9B040@DM5PR0401MB3591.namprd04.prod.outlook.com>
 <20200130155616.GA14682@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cc761374-fa17-4be1-4bec-08d7a59ed303
x-ms-traffictypediagnostic: DM5PR0401MB3622:
x-microsoft-antispam-prvs: <DM5PR0401MB3622477E02EC4A1EEBE6C0ED9B040@DM5PR0401MB3622.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 02981BE340
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(346002)(396003)(39860400002)(136003)(366004)(199004)(189003)(316002)(52536014)(91956017)(7696005)(966005)(6506007)(53546011)(478600001)(186003)(26005)(5660300002)(4326008)(55016002)(66476007)(33656002)(8676002)(71200400001)(6916009)(54906003)(66946007)(8936002)(81166006)(86362001)(81156014)(76116006)(2906002)(9686003)(64756008)(66556008)(66446008);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR0401MB3622;H:DM5PR0401MB3591.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oAdOLDNRDwK4S2d8vqbiF/YvR7qRdZaz0fKBy+FzrE4NNAVxFYWMMjHEbsljLxiG+Kf0Q77BMgjca6L/kWUz4PZWMHhlyciV2ibDOUfr/yaA/lbmdqsFrpMhGNjb2DIjF/me9KJ0a7K6ALcF8Eoqpsj4Jn7jBR5PN0i25c63uPvZt9CVszrYjdJQi6QHuDi4q4HvKCLHumys8MLAI03yFPoMOsCdy3y4Xvx8SEzZW0PAhr48gpDzmTqOLf584qDkr4HQ5uNk6NHk7ZjeXNg0qFTzoYsx1nuw2mBy2yi7C5vkNtc52CcHWMYH44LEpulCc8GwsKyyhTYytJZNNy79Le9tJr87LGV+87wGTJKxFNMTvTslGSmo+vFauZOBK0uc6SmcssbXcE/1RFmAeRC8VL/Dvx4UAj7DNdPz4OfZtAtwQo5gzEUvsj9B5U4+K4/E3SYoj/gz0wxXPTo+ZAvPPCh+RvKkz9pzfLXbZlzpGgyC1NKfK5+pTZulAH+AK/6Dh8W41I1qJCpM7hxwj/0i0A==
x-ms-exchange-antispam-messagedata: 0FUesINsd6OU/35Z/EIjTI5R9dENrbFy9soakV7Ot2CXYBXMI6SgH3Tn1E0emkXFZKsrmmwn1mRFb2acqE1h0pZMOfxJHt0Nb4oKDEXctgCfl62/j77ehpPPvG3SicV9Tt3ZP+iPvwu7k/eRv/YEAw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc761374-fa17-4be1-4bec-08d7a59ed303
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2020 16:09:45.8576
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tGbkEuRjNZSZrNaoJDwAUT2ZUZhi+Jt4RGk/ccrbHOXNZHpttorDWYfBO7PGc6vudZYAY/B6VrTcp1eKV9ERq6hyEaWPctZnewRbKyGrL4Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0401MB3622
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 30/01/2020 16:56, Christoph Hellwig wrote:=0A=
> On Thu, Jan 30, 2020 at 03:53:37PM +0000, Johannes Thumshirn wrote:=0A=
>> On 30/01/2020 14:39, Christoph Hellwig wrote:=0A=
>>> On Thu, Jan 30, 2020 at 01:15:30PM +0100, David Sterba wrote:=0A=
>>>>> Sure but with hch's proposed change to using read_cache_page_gfp() th=
is=0A=
>>>>> doesn't make too much sense anymore at least for the read path.=0A=
>>>>>=0A=
>>>>> Maybe "use page cache for superblock reading"?=0A=
>>>>=0A=
>>>> That works too. We might need a new iteration that summarizes up all t=
he=0A=
>>>> feedback so far, so we have same code to refer to.=0A=
>>>=0A=
>>> Per my question on the second patch:  why even use the page cache at=0A=
>>> all.  btrfs already caches the value outside the pagecache, so why=0A=
>>> even bother with the page cache overhead?=0A=
>>>=0A=
>> This is what my first version did, alloc_page() and submit_bio()=0A=
>> directly [1]. But reviewers told me to go the route via page cache.=0A=
> =0A=
> I only see your patch at the url, not any reply.  What is the issue=0A=
> of not using the page cache?  Also you really shoudn't need a separate=0A=
> alloc_page - you should be able to use the already cached superblock=0A=
> as the destination and source of I/O, assuming they are properly aligned=
=0A=
> (and if not that could be fixed easily).=0A=
> =0A=
=0A=
Care to elaborate? Who would have cached the superblock, when we haven't =
=0A=
mounted the FS yet.=0A=
=0A=
So here's the answer from that thread:=0A=
=0A=
"IIRC we had some funny bugs when mount and device scan (udev) raced =0A=
just after mkfs, the page cache must be used so there's no way to read =0A=
stale data."=0A=
https://lore.kernel.org/linux-btrfs/20200117151352.GK3929@twin.jikos.cz/=0A=
=0A=
