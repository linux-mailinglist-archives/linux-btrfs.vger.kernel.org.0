Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB8C93B5B6D
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Jun 2021 11:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232284AbhF1Jgs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Jun 2021 05:36:48 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:54512 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231935AbhF1Jgr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Jun 2021 05:36:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1624872861; x=1656408861;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Wchmommzqt5Wp8GhJi18pjypP5wJobHEO9/dzXrrvMA=;
  b=djp9Db8ZhzO69fAg3gKf7SPAaPptOh0107TiyNRh6rMSFFswWw/ZQNl1
   jgtFsl+Zt9QuRo4aTlTGB7AwBQ/fo5ZPitH1u2fNTV4sHjk8sDGzHPvx/
   4c6AC7DkLcPA38heP39T4fAibFJ2qPTo+OD2DnjMiIJRWaqC5h6AGSiQC
   DlcFWRpMq7g4mXnrCkQ+023ovEUBU848HDfjtk9UGqTlX33bv7x8swZKb
   WyUPit4KoU36A9Ifg2rRP2DxMYUtZtPg3XuUEiOgUZ0IvQi3S1kRLOS1M
   +QAym7xlW5M/VRuDEFElKavZMscdg/MhRylaycpQdMximWrw7j5NCLSxC
   w==;
IronPort-SDR: RZt5KKRAf5BNqjHSUlF4UD23DLqe4Utn4ITyP+OevtEKxyj+wAoEeRukHougwis6BEpxbDzhNo
 mv29PmBdWo6YD8lCHvbfM2HYYXfO6a98v28X9sZqcIqGNmfg7qs6xXogJRr9+I/HtY47F2ByUe
 zA3H6a2JT6oBhxhkS2sQ4GqPSrJJltalId2qYZME1lRkCsEbNSsi3ptUcTe2DBkvu8ygayVWVG
 9fpo5bOQUJuYiMbt/r9EsP9vWyrkecAqOq0fvDEQ9KOTaVqu6De05wvepDI9hABV49W/V79rJZ
 R+s=
X-IronPort-AV: E=Sophos;i="5.83,305,1616428800"; 
   d="scan'208";a="173081270"
Received: from mail-bn7nam10lp2104.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.104])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jun 2021 17:34:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mVYe2PsYsQHdy15tNWts0JiGPwlS0MxQSYH2i97B+TgCVrG158uE2052lTorROCb57quNZOgDq46/eX0jHJ4XxCyedAp2apM85O2Yd7jCfZYvY0MaXclKzEd5rsSgMjj4BbcAJsLKYmYsapjJSbKcLNXi664I81DrQ4umabAqUH6T26/iJ+NqtoU2/CZfurFdpV1RZoHwHCdRHNVYTbnV+Mp2XMiN8f6AdyYvl135nND+LPayG1FvNiKguSE2/yYnnKlj6FVajhYx4UrIanSfRF9wE3jr4+kgLja2tC2apC5331SHXl931BxZ9k23oPtr5sOVhCzQIF6oNZDN1oMiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XXxPQI2SGUp2x1PdKOUaGup5khWyqNyVXpncpv1zwGU=;
 b=bBX/EW9QoH4PLZ8PeuM6V58PifPW10GCWpHcUqK8c/9CTuYM0Y7m2kLVTqErbl8t/bAD4WC/N4HoFY2INs3gD+Wo7twTswPyBizMwcjp7J9xRsiAJ8Wqf0rCdU+YwxAnH5EjEYPUNZs2TUMjkZ5hgR3KmDyLN1CKpbp4eNpaitTsTveV+psIvsLsbqsXUiyeHyp6g1PbDfNE8oyr8UbPLDnx4UD6VD2QT8sGezajrMu5nmS8qHGfej6OixbfktVw5gejGsQ/P9EtjlXrNR3DuPxzPWPI0gP2vAFCx6OJibxu24UVLrRK3gKeTLijGt2TnmKi6tvBJV6mVbfC7N52nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XXxPQI2SGUp2x1PdKOUaGup5khWyqNyVXpncpv1zwGU=;
 b=EyxVhO6tBxxzkhuhm9BE9pNHo9UmSExIrT256HJoRbjhFVb8/Zl5WrAuB24HuCV7J1NOjDmVy6OD2MEIMG7KmXv/r2m81PhoFMhuol9JCeQVnejCQrCHaBUkiV7QP4JtiCEdMAdZZCsaxbRsYgzEq89beucCCEW+TUO2Io2H2to=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by DM6PR04MB4474.namprd04.prod.outlook.com (2603:10b6:5:20::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.20; Mon, 28 Jun
 2021 09:34:19 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::a043:568a:290e:18bd]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::a043:568a:290e:18bd%9]) with mapi id 15.20.4264.026; Mon, 28 Jun 2021
 09:34:19 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "13145886936@163.com" <13145886936@163.com>,
        "clm@fb.com" <clm@fb.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "dsterba@suse.com" <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        gushengxian <gushengxian@yulong.com>
Subject: Re: [PATCH] btrfs: remove unneeded variable: "ret"
Thread-Topic: [PATCH] btrfs: remove unneeded variable: "ret"
Thread-Index: AQHXa/qIqPYC2XVGwUGkFAjG5cdOuw==
Date:   Mon, 28 Jun 2021 09:34:19 +0000
Message-ID: <DM6PR04MB7081A02339DB3ACC72F86261E7039@DM6PR04MB7081.namprd04.prod.outlook.com>
References: <20210628083050.5302-1-13145886936@163.com>
 <ee06042f-da1a-9137-dda3-b8f14bf1b79a@gmx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmx.com; dkim=none (message not signed)
 header.d=none;gmx.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:49b5:3cc7:e59d:b478]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 46868983-0b81-4c7f-c398-08d93a17e7a7
x-ms-traffictypediagnostic: DM6PR04MB4474:
x-microsoft-antispam-prvs: <DM6PR04MB44741D2B6BA84935B6CAD372E7039@DM6PR04MB4474.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:901;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vqs1GpyYw41045FfZYbBui8Z2bP871oXATo56mNyuGxSXSdssFjFWXXD0++e8E1YAV970Fo31UVwEyXhbmnSIPV3Bt9Cqyad4Dg4yltxVfw9wuOGoIbPIuCiu0M+mQpYr2d9u8RPYrhiXhZ5FJHAHzlZv60YonzZ6O0IPYOWNAkimZLFBOoLl9Q/Vu0vPraJUe2gOYiLTzjAD3MlAjgSsOvMLYalfsaB8P/Ob4BHkUhXRZYJLmW7UXzUAM1VhIN7Z/S4ZNFohihl5e2bnBlIV9N+94NW3X1UcG5UjY63xOgkmCcX9EkPThMNMP7LVGYJjelIaWROYKnSFphKYVLqZo2teVoull29HNqQ0M4vlgOEwu6xAmNfQU7xxOrJrS5ffoSvNNvRtDlgLYSUDQC8hrABRLp5GcBR4m+mmSTcUkeabodHq+wgxwrVQ5Lqo6UM9BsbXmPT3WHFfi2rO9kD3AxSYxG+SPVfMy8CkJDrlQsKUQpSi2Lfija4lkTdGt98LNHJOpDVePTJnyPU5ka/8HWUstjlGaX0i9eQpLOH6r6MA6+h9YhZufK/dyZov97QBuS83dPdy8UA4NSjdNSskwyL4dMuo9Xi2s/XJlODUmKvdaFpaqA5yX/vh936shYkX7ecj8btFCkedAruE3Vd2g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7081.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(136003)(376002)(396003)(39860400002)(7696005)(110136005)(2906002)(54906003)(9686003)(478600001)(122000001)(55016002)(6506007)(53546011)(5660300002)(83380400001)(38100700002)(66446008)(64756008)(66556008)(66476007)(66946007)(186003)(76116006)(91956017)(52536014)(4326008)(8936002)(33656002)(8676002)(316002)(71200400001)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?RWEwK2pCV3JibGZFUlJ1R1lrMEp3ZGhJdjFUWlYxeTczR0huWjM2ZWNp?=
 =?iso-2022-jp?B?dVF4bmVjNjEvQXJaRGtPVDhpYzN3d3dlNjZYU0NtZ0NTZTBic2tJWktO?=
 =?iso-2022-jp?B?SlVXdVNsQTh1ZlBUeWIxSFVaQ0RXMHluMXhTQ2FrOHBPNm5vcERSMDdB?=
 =?iso-2022-jp?B?blNFYUtFWmh4ZmJtNnJVUEd1VFMrMk84b1U2MDF0L2xNcHFYa1dDMUJL?=
 =?iso-2022-jp?B?a2ZoZjdVc2VBRWw1R2FDRndwaWpHNzhINC9MQ1pvRmZPaURFeTdsc0tI?=
 =?iso-2022-jp?B?SVNLa3FKRlQ4endxL0NIZmhLQ3VYcVI3SmdUenI3b0w2OUpxVGFNa1Fy?=
 =?iso-2022-jp?B?SU1pcnhyeWgxRmJabGV4YmtaMk5SaHpSSjhQeHNHcW8wNVdjVWplMEFo?=
 =?iso-2022-jp?B?eVlLaTVIWlZlTmRQcDFzTHp0VkRyQVMwYzdDdEJPVWpwSUpoOFJ6VmIz?=
 =?iso-2022-jp?B?Tkg2U3psRmxMVzcwUHFPNy91d3E4QjNSVVNZZ2NvakE5Y01VU056VnY0?=
 =?iso-2022-jp?B?SzRQVlA0QllNYkZBZ2J1RjhHaHoxM1oyUTV1c1Y5aVpGV2EvVE01WE1i?=
 =?iso-2022-jp?B?YTFRQ1ZUd1o3bkttdXF1MllTNStvakpHRGZEYkF5WVRQTkNTWEo0aGFn?=
 =?iso-2022-jp?B?S3hVdXdJd3gyNXFDbHZhcWVtRGlPYmxvbEJTdFRDS3N4KzRuRVdwRTRN?=
 =?iso-2022-jp?B?d2dMK1pFbnBiVDFxaktjV05BZjNRQ0hMeDczV0F3MFBnaXhlME5naEY5?=
 =?iso-2022-jp?B?dFJBTUVQSHJlM1FXbzZ2dldJdjg1ZlR5dWxmdzNEa0dLQzZZRHpPVHlE?=
 =?iso-2022-jp?B?YkpkOHJkL2E3bmZ2SElLUWJUZjhhWU5XRWZoTXRuZnZLbnM1U25OSGdQ?=
 =?iso-2022-jp?B?bm5mSFlIYzlQckRhSUJvdHkyY2FScFpOT2FxUk1PcGdCS3FzY1NhZnhu?=
 =?iso-2022-jp?B?SGoyZGtGZnl3Mmk3cm9JMTlVMFlKZ3pNWit5cjRvSGwyWjJmc2hQMzBB?=
 =?iso-2022-jp?B?YlBvV0hXY2hYTWhINEtoUnlObHdhRFZDYW5GUER4THVzakpKR0lwR1dl?=
 =?iso-2022-jp?B?Q0ZyalJiZzJrek42R1Mwa0tWakJZcjd3ajBjQldlU2lmaGFSUlh5dG1U?=
 =?iso-2022-jp?B?VEV2ckhJcHBZQk9GbGIwZWJRVlJic0JQc1ZoT1RNd0liUEtyVmRBemVm?=
 =?iso-2022-jp?B?c20zTFFiOGNsS2dqd0dmUmVWNFJQZUpZQW5RS0cvZVl2TGlBU1pCSDMz?=
 =?iso-2022-jp?B?YU1UMEtYVjlTZnFRb0M0MFRtN3QwMjNMcmt0MU05RSs0ckpmeVdZUXR0?=
 =?iso-2022-jp?B?a0ZLdEdxcG50eGtUb3dsaUo1RFMzYVE3eUR5Y3pMZHF4cHluY2ZxcVZH?=
 =?iso-2022-jp?B?QTN5OXphbkRjUHpkUlB5MGtkcnJGR0JmQVBabFhCc1YrZHJBeWk3V283?=
 =?iso-2022-jp?B?SS8vSDB0ZXNSNFUzMlg4OVdGOTlQckY0YkhjUmtFcVNhdUNrWVpPYkwr?=
 =?iso-2022-jp?B?akpxelE1bHhrRFlGUHQzUUtUZlRoTEtmdnpwaGQvZk0veUZ2NnRvSTND?=
 =?iso-2022-jp?B?ck1oVURQRXFVbkd3dCtpcTg1QS9YQjRybURzWEtCNUxORGVmTzZ3ODJJ?=
 =?iso-2022-jp?B?clk4KzROWGVocGRBbGdUU3pzYzRNbXAzdHAzYXhZYm5yc1Bwem9CYTdv?=
 =?iso-2022-jp?B?Y0VnTGQxWkRWNGpIdTFIOUNuWUNWMlRXQnhiK1FCNXl6MWcvN3pRUk43?=
 =?iso-2022-jp?B?RWkyZ3JWd0hlbHNDN1YzKzdndnZNKzdNaTZjV3F6Q3VKU0MwQWxkSGtQ?=
 =?iso-2022-jp?B?RDV5RUttQUlxY3c3WDAycW1VSzhVSHcwM1BNZys4RUdZSmxDWTRTdGVn?=
 =?iso-2022-jp?B?b3NLQlE4QUZXZ0FtTEtGY21aQ0FtWC85QTZkMURiYVRYNmphNmpjTzBX?=
 =?iso-2022-jp?B?RWhxdzc4Q3lsYjl2TlBHZHNib0VVODIxVEtZWUZJcFZvVzJpNktmWlhv?=
 =?iso-2022-jp?B?WUtEeVQ1M0ttMHJDTzJqZWRwR3JzNnU0VHN0a2JGTVVqUXF6MitMVVZX?=
 =?iso-2022-jp?B?aUE9PQ==?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46868983-0b81-4c7f-c398-08d93a17e7a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2021 09:34:19.3840
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tVEA9uwlCDaSCNjJsPRc8kinqLFSovWOzijrjcHW/0V1Blc3TQQb3DQn0Qqt8Me50qSfcUIvBDxajqt3Exdw+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4474
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2021/06/28 18:22, Qu Wenruo wrote:=0A=
> =0A=
> =0A=
> On 2021/6/28 =1B$B2<8a=1B(B4:30, 13145886936@163.com wrote:=0A=
>> From: gushengxian <gushengxian@yulong.com>=0A=
>>=0A=
>> Remove unneeded variable: "ret".=0A=
>>=0A=
>> Signed-off-by: gushengxian <13145886936@163.com>=0A=
>> Signed-off-by: gushengxian <gushengxian@yulong.com>=0A=
> =0A=
> Is this detected by some script?=0A=
> =0A=
> Mind to share the script and run it against the whole btrfs code base?=0A=
=0A=
make M=3Dfs/btrfs W=3D1=0A=
=0A=
should work.=0A=
=0A=
With gcc, unused variable warnings show up only with W=3D1. clang is differ=
ent I=0A=
think.=0A=
=0A=
> =0A=
> Thanks,=0A=
> Qu=0A=
> =0A=
>> ---=0A=
>>   fs/btrfs/disk-io.c | 5 ++---=0A=
>>   1 file changed, 2 insertions(+), 3 deletions(-)=0A=
>>=0A=
>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c=0A=
>> index b117dd3b8172..7e65a54b7839 100644=0A=
>> --- a/fs/btrfs/disk-io.c=0A=
>> +++ b/fs/btrfs/disk-io.c=0A=
>> @@ -4624,7 +4624,6 @@ static int btrfs_destroy_delayed_refs(struct btrfs=
_transaction *trans,=0A=
>>   	struct rb_node *node;=0A=
>>   	struct btrfs_delayed_ref_root *delayed_refs;=0A=
>>   	struct btrfs_delayed_ref_node *ref;=0A=
>> -	int ret =3D 0;=0A=
>>=0A=
>>   	delayed_refs =3D &trans->delayed_refs;=0A=
>>=0A=
>> @@ -4632,7 +4631,7 @@ static int btrfs_destroy_delayed_refs(struct btrfs=
_transaction *trans,=0A=
>>   	if (atomic_read(&delayed_refs->num_entries) =3D=3D 0) {=0A=
>>   		spin_unlock(&delayed_refs->lock);=0A=
>>   		btrfs_debug(fs_info, "delayed_refs has NO entry");=0A=
>> -		return ret;=0A=
>> +		return 0;=0A=
>>   	}=0A=
>>=0A=
>>   	while ((node =3D rb_first_cached(&delayed_refs->href_root)) !=3D NULL=
) {=0A=
>> @@ -4695,7 +4694,7 @@ static int btrfs_destroy_delayed_refs(struct btrfs=
_transaction *trans,=0A=
>>=0A=
>>   	spin_unlock(&delayed_refs->lock);=0A=
>>=0A=
>> -	return ret;=0A=
>> +	return 0;=0A=
>>   }=0A=
>>=0A=
>>   static void btrfs_destroy_delalloc_inodes(struct btrfs_root *root)=0A=
>>=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
