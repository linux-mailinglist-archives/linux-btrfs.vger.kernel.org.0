Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19522525F6D
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 May 2022 12:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376424AbiEMJYn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 May 2022 05:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231895AbiEMJYl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 May 2022 05:24:41 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B714E289BC8
        for <linux-btrfs@vger.kernel.org>; Fri, 13 May 2022 02:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1652433879; x=1683969879;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=oatLMA6nTy2w2KDGkaMW4+XW6Q+DNDzO7czB5xksn6A=;
  b=bJ4uhjSU/0L3618C3gAO5zZOUUN6ZEZIMnyIPkIPO4c5HC3HLhXhxXJt
   SsFGV0RPq8TijzTvpN/e8GIqVOq1McqN3FnlXmv+g17EfxzRrqyZKvcSg
   QQ55c6WpjJihDSEN0oaBLxhYZHo8lbxoZH0nBWM/o2tQ2sYBOdLeCH/aV
   wKyvVFGuDTI6cTY+ETfQzjrciM3BEzDDHf7Ab5b/rtQPixpWEzHTNGPcp
   j4JkIaciGSubRkjXR+uCmf4sQaNybOzk1IT0Dlat7qYPeBTyjfqm4uRrS
   90n5EclNzUi937f/dr+HwWw4EbPE6uEq198eUh5uBND+zWhevq4y722dt
   g==;
X-IronPort-AV: E=Sophos;i="5.91,221,1647273600"; 
   d="scan'208";a="199079278"
Received: from mail-dm6nam10lp2100.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.100])
  by ob1.hgst.iphmx.com with ESMTP; 13 May 2022 17:24:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jcB/vQM+Xp/IHYlv2UuuNfNZCmClmb1p+YPOCq4rm88GyG4LIG1cfnB1qKdW9mAUurTLvdKv/0cb1OPX5XmeSds8pt/bOmNBWYuHJqQcIj8YIAvGKc7PbhD3xtwqbCazSHnVV+dlWUVCNsn/No8IJO7LtZ5VEw6v2Q1S/B3XCprRENUOxPD5goI1zQvCy3K+02Hvii9ICJjeS8OlbVgURjRX9khzlRkj0pfWU41grjG7djwYfzi5GkhJBsUucBfgrO7fscIZGQchEemYtpDS38K79VeGaPprBybHITzPPFHziWXdKv0WOLsib6wJ5tcamJxnS4ltmFO0Z1Q3nMpEeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k8agCGEA4BH7J82Uxzp1e5fuo6d2+iJZCJXPXvTwAxk=;
 b=laLLfmu9hbhMm2O0RAKh4Pvrt8lz0roc70bV5+rHWMgHRfyjnutgAI4NreFyB9A55sYG1f1Euj7+XY2VW5J8SXBj2gdtDX3P6M0zPgq12fZzSXoVhozSqbcOCAUl2OtJvyqMNerHvsNAhcLfnqZH6RXwbOnxVe/MKexpvUGIgGnjqiCUZM5iH3woUyB7Imq/VV7pSY3nd0y9zabZwEZIJGDfKunsryA1xyZrcyifX56fCg0IN6JhlfUutCtxa3JtPoagS0vmSzUC+zQtutT0RNJNZeIB7Hvn8T8qcV4kZiXwM7sGBSNTiQBe9YZ79S5z40owd8BRfURx9tIjQPINjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k8agCGEA4BH7J82Uxzp1e5fuo6d2+iJZCJXPXvTwAxk=;
 b=ZEa3aYC83LX2GitlyH2E7Wt6iDYMeVY5V2QwevjKrPdbUQEpIYhEIo+x1g3CAQwrnvhoJSZc5TfY0kzos3MrQmpbXm6l/hU7cOpexkqc7NK31NLk0M8LrGBJlvdm34FgoC49Hcwdsn8sRWk2SM8mdgm6pLh+eCo5zpe6lJb3sE0=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CO2PR04MB2199.namprd04.prod.outlook.com (2603:10b6:102:d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Fri, 13 May
 2022 09:24:34 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12%3]) with mapi id 15.20.5250.015; Fri, 13 May 2022
 09:24:34 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 4/4] btrfs: use btrfs_raid_array[].ncopies in
 btrfs_num_copies()
Thread-Topic: [PATCH 4/4] btrfs: use btrfs_raid_array[].ncopies in
 btrfs_num_copies()
Thread-Index: AQHYZqRPMtqV3WP2mUKwGY03tL2znw==
Date:   Fri, 13 May 2022 09:24:34 +0000
Message-ID: <PH0PR04MB74169DCF588F328DBE0D6B1E9BCA9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1652428644.git.wqu@suse.com>
 <a51939d1e568f36135c8f0383a4f34da5bda0f4b.1652428644.git.wqu@suse.com>
 <PH0PR04MB7416E0CEDDA84965B0FDD2919BCA9@PH0PR04MB7416.namprd04.prod.outlook.com>
 <ace856f6-b1c0-6746-797e-af85ce6a0f0b@gmx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 629bb2a9-ce00-4093-8a0c-08da34c264bd
x-ms-traffictypediagnostic: CO2PR04MB2199:EE_
x-microsoft-antispam-prvs: <CO2PR04MB2199D2FADC8A1A8C551D97489BCA9@CO2PR04MB2199.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O3Q8+kpjn2u0aegXuVTl7U1dH+Q+obtaYFCZkmo+KcfapcIpLa4SLhyf9qmZjhXzV3IKdftww3X52a1olKNNXBqNUJ0z82WRzTF70WYGg1HBYeFbt/ahCDSR1P1FdWGTbylxvWEW1qmOSqXpN/VZQsXvzGSgzo6iVoqvDNLH5t0f72yLdU5vzn8iL8qI0qwfy51CagmPg4SuBXUXTKrFisndkIrjDmF+GKSBd/linB5Yuq6m8NT4ILU3UdJLX56bX3tWo24fbcloRXibBFL+Q64mcsKL7wfevQgXBat15XVPh42p+wCtSsotZt2vs0MorKplQVoRYkbPQLQR6S92RvGW89wD+QePCVN1encB5pU1dgjLjtNyBNzjIPA2/rmDz3H24RjYT1yUHWPrFfIreaITsGACoPkdJLktXhNTxC/c5TPMF8o4GHlcqOhz6A2C1KOfHksg2KgFIfS3sVm5ajOxCAt9bt3WsEn7funEqq2CDd83Fcot05C9nlBokZoF7ZflvXQ89VXzOIvzM27XqvrCyq/a5YIvA0R5czFIqyMACHu0qc2UHFblp3RunAvxn/wOtTZN6RVA+15PIrd5hvN/66UQ4QtTaw2isUOexik6SYTywrOwPxRZ0RTj5/QZ1clXl6KT+u+pqAP+B1rqQheTCkF5IacbpdepPhPOhf0kNhRNb0bfxk2sUrtAkKKjCngZwGceKxx5olHHhD4F9w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(38070700005)(26005)(83380400001)(316002)(91956017)(76116006)(38100700002)(55016003)(66946007)(66556008)(66476007)(8676002)(122000001)(9686003)(66446008)(64756008)(82960400001)(110136005)(71200400001)(7696005)(86362001)(6506007)(53546011)(186003)(8936002)(52536014)(33656002)(508600001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?06nzpQ/sOJKu/W3dL3nCC2FEWoqJ5lhZL76PM/IvIIb2J9BgKZnzWHJ5OHpU?=
 =?us-ascii?Q?PUVmZtm1h3yndAzR/D4sOFtZrcVyIeP0yw7DH/ZxmnLxQNPnPg5bIdg6sE+a?=
 =?us-ascii?Q?AlhVEvaV+kZuHB0MRC3zRTMjd1g+hkOVp3UaykNkMjvCsM8iArkd4U/MZD8H?=
 =?us-ascii?Q?e87ttncD2TC38UdT5fPRzstGoNLW3tfNjScEIiyRKF1KUuQAAf3+D7udD7Hy?=
 =?us-ascii?Q?0yI3nGDoIFH24cs/5NdPLQkxkXK+O1lDicWL27p9iXnBKIbPIzeIkQvqV4ZM?=
 =?us-ascii?Q?WICVRSHNOzhK4J5OQzaOmKMb9Ca/D8lD2czLjIRnqv8qSD0KNGduFQRdPqrH?=
 =?us-ascii?Q?hSHRxMLreSy6RS4WH+JDMomClUVyRVOz7BiKm0fSfcBBqgLRTnJIH8JM4Led?=
 =?us-ascii?Q?3shMhiW562hGT0byFM7Q3jhFdQAw6BO+ztZUl+m/YWLCnhqKW8wk2IJqwRRL?=
 =?us-ascii?Q?O0h4DJlu3BCYxFCmqUO1odAqAVaR7OZShazGcOqf+QArjpI4XHQrROYVSkFc?=
 =?us-ascii?Q?PcZf/pnt9h36mF/rG+Qg/GPwPpdV7YhJeas4b1QFcP/mRFhzuu4zWWmjAzPx?=
 =?us-ascii?Q?FuqdI59hj1HIlF/+UIEZkAPltHoYeMfoUk/OddMzIXhFC+S958Qjg4GSUIzr?=
 =?us-ascii?Q?/biADEndZc1EJMMZnwoQek7o/SiO3IzqqmLgWABLXnNoJM/HKl93pwDmcPKq?=
 =?us-ascii?Q?2VLGaymsaoriOBCMuP7oxRvhcImI0JIIqgTjM3XcZG62xUMJjEXrET0qjXcD?=
 =?us-ascii?Q?Tpf3ZIus75rm5/8izHJlH0JZ3NDvBcUn3Ut2ms3ntnp3Y/sw6Ogrfms9afXM?=
 =?us-ascii?Q?qbeoaHiXnYimT9iHz9cWY8R3ghfx5qhovTYIaHYqzER8M9FNGkuNDUf9UyvC?=
 =?us-ascii?Q?6KKippFqE4V/YqPMOBvoUn+y1Q/sTFXBRtnbLDxlINR2cyZAH+jwH3ugaIry?=
 =?us-ascii?Q?JdS9xT8v+Wq/t3vqDM3oiDoSGf6UKL8IMOvQwOyD1kW3U1T7I7pUG4Uuopz6?=
 =?us-ascii?Q?IPonUZfz3M8CCYuFXgo01tMUbyDyn/EyosUGNEAdMhEemO6JGlvZMu3LPHhO?=
 =?us-ascii?Q?B0NqiH/5Lw3Je229mdiiCFz4bEPmxCWUWD7Fsry59ap8y4htsWv0QfFkRfnh?=
 =?us-ascii?Q?ow0DO8WRnwx160PI7NQlzbzDs6kst54FedErsRun0U/0GBmReOfmNUj5r7+8?=
 =?us-ascii?Q?poeYww5BTThaSnSNuZHsD2u/CY16njbFXNtFGFZ+G5yfU+Ai1WRYUOazIkLj?=
 =?us-ascii?Q?jYDoeFtJT3U73CNs3VUY+WxNiJ2CjT96xfou18J8PSu3vhImyitfQaHKRlbD?=
 =?us-ascii?Q?RIKTRPn5Wp4PWFt/hm/+/Y+jfti72bbXA3nDDjMkPY0evxzn2HlS7rtz4cdh?=
 =?us-ascii?Q?V2XG0IFS6i8ZTFmen0afN9O6czJEcXATCtwGo62W9EK84V7EpILRxNullF4H?=
 =?us-ascii?Q?7wkok17J5WxdsJ5+N4D7KNGDwoV/shB2vItnd8Jpev6xWEOMq97LZ1gepYcH?=
 =?us-ascii?Q?hF0pBLB/4//UdCK4vpJkzCR2e51Y9EKJqVhSYB3TAshcSPjxEI62rwHmmpkK?=
 =?us-ascii?Q?cdpDnWiJWByVdWlZyxrkoWM8nKbho+EOGMHn5lolHeagDLq6m8b2T6C7QBCX?=
 =?us-ascii?Q?UFWN5Ll+Oj9YtnHYjrp8NMwmTQCqJpvFdPlz5X2NPsmQCgREA36vOLrykcpc?=
 =?us-ascii?Q?NEByn9UXmItJys3OktCn7AczRIdJyxj38AL9Bo7Ew9qg0pFrWPrcdQXhaq35?=
 =?us-ascii?Q?ty5bEeAIo4Ae6Idm6SBYldmxpVHfCcY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 629bb2a9-ce00-4093-8a0c-08da34c264bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2022 09:24:34.4633
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ufJWqovry2EP2v4FBJQF4Jv/hPbfsMDGVQY7Ov65U3h6ITIUAdyhiudFxNXctgcAzW76f2KqK8ijQ8740QyzfMePxPxAapWBmhHql960mdk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR04MB2199
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 13/05/2022 11:22, Qu Wenruo wrote:=0A=
> =0A=
> =0A=
> On 2022/5/13 17:15, Johannes Thumshirn wrote:=0A=
>> On 13/05/2022 10:34, Qu Wenruo wrote:=0A=
>>>   	map =3D em->map_lookup;=0A=
>>> -	if (map->type & (BTRFS_BLOCK_GROUP_DUP | BTRFS_BLOCK_GROUP_RAID1_MASK=
))=0A=
>>> -		ret =3D map->num_stripes;=0A=
>>> -	else if (map->type & BTRFS_BLOCK_GROUP_RAID10)=0A=
>>> -		ret =3D map->sub_stripes;=0A=
>>> +	index =3D btrfs_bg_flags_to_raid_index(map->type);=0A=
>>> +=0A=
>>> +	if (!(map->type & BTRFS_BLOCK_GROUP_RAID56_MASK))=0A=
>>> +		/* Non-raid56, use their ncopies from btrfs_raid_array[]. */=0A=
>>> +		ret =3D btrfs_raid_array[index].ncopies;=0A=
>>>   	else if (map->type & BTRFS_BLOCK_GROUP_RAID5)=0A=
>>>   		ret =3D 2;=0A=
>>>   	else if (map->type & BTRFS_BLOCK_GROUP_RAID6)=0A=
>>=0A=
>> Here I'm not 100% sure. RAID10 used sub_stripes and now it's using ncopi=
es.=0A=
>> The code still produces the same result, as for RAID10 ncopies =3D=3D su=
b_stripes,=0A=
>> but semantically it's different (I think).=0A=
> =0A=
> Since the objective of the code is the get the number of mirrors for the=
=0A=
> chunk, sub_stripes is definitely not correct here.=0A=
> =0A=
> Just imagine if we have RAID1C30 (sounds ugly I know), which is RAID1C3=
=0A=
> first, then RAID0.=0A=
> =0A=
> We should still have sub_stripes =3D=3D 2, but ncopies =3D=3D 3.=0A=
> =0A=
> And the number of mirrors is definitely 3, not 2.=0A=
> =0A=
> So it's the old code not correctly semantically.=0A=
=0A=
Ah ok then. Thanks for the explanation.=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
