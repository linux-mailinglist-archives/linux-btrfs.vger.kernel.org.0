Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 774226A07D5
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Feb 2023 12:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233248AbjBWL5V (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Feb 2023 06:57:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233157AbjBWL5T (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Feb 2023 06:57:19 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9281521E9
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Feb 2023 03:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1677153438; x=1708689438;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=Bvdss58Buh8ayKeTYfi6F0wKofeL8DS3yEhNVvnSB8q2ZDzybd+tX4Xj
   v9PAcrXq2DS2YqjwyWmgHPp6gsIKeKDr1X4UzP0KdJi8Fkn5E59vtDizT
   yXhHerv1zbIKj71QmC/T7d3wMLMrolBmCwZdedY/4G1MsGqARvs+wY2zI
   0D2YSRaGkdG35i5fj7DwvxhI2uP16iC0ldUu3HMNezFppwJrcBIyzhvXp
   VfHvLDVuvWWeuBr3TOujh/IhIWYxj60YC44Tdtk5HMH7Gmu5iL/tbQVk7
   mHTbQvuIXaekqtCX4143YKMb73oj90IQNkwWnvlCQ2R7jAsa7ETjiXpUL
   w==;
X-IronPort-AV: E=Sophos;i="5.97,320,1669046400"; 
   d="scan'208";a="223994950"
Received: from mail-mw2nam10lp2100.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.100])
  by ob1.hgst.iphmx.com with ESMTP; 23 Feb 2023 19:57:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dT8oJuEfminTw6nXm2VqwPWc5FdKOx/nDZV3LWT/7BkFD9EgEJFnvpawSDpDn1lwrAH15XQXoYt2jAFwj1pOV33HdtQ1rfY2yHnYvW0pf2ifaQ/b3/7nuZB6RtZZ+tZevW8tiYIcbKXAR1sYncV3MPomAUxClLU9R5Osi0l5+OuLxX0DCM6BTv0wA8FOZFzVVF6IeZzNPLZytaigN2S9z78uWtB1x+OC1taLfWb6LVjwJy7pk5S/9UtFhen+BM8drINes5Buo0LKXMYxDHVlj1QaQuAshnnm69BPbXleXklftfUeXaM/vh0cWfVOoQcnGCLHZ1LRF3xnmXaZRERESQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=O8MwO+XjH3GX38fuUHq58hI93n0KxhhgfV2kIFUxkY7nQMcLat1RwdKV3lYo+VVm/TnaexawSAWX9W7xjJ1kmVnCRxau8lMgoEwquEsgLwo3dofHnVxSvJb912vHKGv6gAz5FdwrcQVzL46us0U0MCijOmFcNbT3X0P5r2nvsClB/9ezpXDrQW4Xaak/OyQowZzBioAB8cRWVawh7efftJPj2bljWWtxKx0JXDZQqW2unBCmpzy56h600AF3yncpfD6tdXc/xTzbjxpjh51SIH2erQWvsNCqB1kLbGUCSTh7G+kckJxA8K0AFQxoYJLN0zC527fE8ZReNFZ72K97tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=bdoJFDk5FKqlyR3Vh89DwaoHpcNxPENzw6ORSyVWeJsBd8b0sGpq7fPn2GuKNGZi276Tcp7vmbBMIs3JnxRzMaz4oHCbypWLGYOr+uDwbjxrlTotyACqPlW+onHPJH1mQ6qIGQIxstiMDy2X1cXATzZbS23T1ENxpAIj/gukODg=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BY1PR04MB8678.namprd04.prod.outlook.com (2603:10b6:a03:529::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.21; Thu, 23 Feb
 2023 11:57:15 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%6]) with mapi id 15.20.6111.021; Thu, 23 Feb 2023
 11:57:14 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 2/2] btrfs: cleanup btrfs_lookup_bio_sums
Thread-Topic: [PATCH 2/2] btrfs: cleanup btrfs_lookup_bio_sums
Thread-Index: AQHZRuBKjE5gUAOUHEivntWxnaC1Qa7cbi6A
Date:   Thu, 23 Feb 2023 11:57:14 +0000
Message-ID: <8e6158c2-f127-c67a-bded-b46bdac4344a@wdc.com>
References: <20230222170702.713521-1-hch@lst.de>
 <20230222170702.713521-3-hch@lst.de>
In-Reply-To: <20230222170702.713521-3-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BY1PR04MB8678:EE_
x-ms-office365-filtering-correlation-id: 6bcfe5cf-66b5-4c92-6a20-08db15951ae6
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xz/P4acK0CcSzY3MNvXlv5yP9psLa35nayF7FJZZhRNXT0eHLb9NepdH3gWqQ1pUxxtl3n8BXlW7gpgi5Q6ZKON2dIRHpQVz0DPWs1R+edsa94e3LkDXIBdWytdb63pneBXeOrrQgFlyNc7rtfICCwOuR8Qxy07WLxDBfhMGZdReU6us3QTm78SwLOWUO5ATiJ874LhZSyF+sCRArcp7YsYBXuVfyECbwz9wiokYFsRsi3+ti16LYJw5QKZl2cNXykvyB1c/LK0YunS3979OFQh4vIpKwY+xs0ZdyEPeDOwrjLKVp6PMOiTnudx9QKp4hBYLzRNiExTRWSbgyX6d/Ud7DRh0k2u3/y8D3JOym0L5EhEu+bRsPILqio1fylVm7vfOGJTwuVEoiQAWXAZ1zqs6Gh1vjbHGkgddwruFR0WzW7Vh3Y8RKYXvo/OLkOhroVr/pXMeq9vVQkrnDPDH0oOIWwu9SIDYCT6DNZSlCUKXICTDGdUfwJxxbTLqlEnHbGtnqNlu9PlP2w9vuopuyS9JxZxfyrJlQFi8Ktai7Ypp8NRrAwzFsArXak2qIsd9Nlgo0Kc0eg08Nf6KW7iYfqYWfPqk+0njhrwHSXZl+9liv0yYJnwekzi3gZjfYa4eN/fIF7WN1/MB4U8nAe2qBRski238NTBmVr6w2s04uOHqD+GYDhFAyNaqpIJacKBu1P3/ATc/ZpCG/MrJ6d4zUDaJiVZQGmFpVYTvUVfjqaUkpYRBAQ11x/hBkdAw+z86H4JNIX7hiWE6gu79BbM2Ww==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(376002)(366004)(346002)(136003)(451199018)(71200400001)(2906002)(31686004)(36756003)(66446008)(64756008)(66476007)(558084003)(316002)(122000001)(6486002)(66556008)(19618925003)(41300700001)(2616005)(91956017)(66946007)(82960400001)(6506007)(6512007)(76116006)(31696002)(5660300002)(478600001)(4270600006)(110136005)(8676002)(38070700005)(4326008)(186003)(8936002)(86362001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cVhVdDY4VzAxU1BiK2pBQlNINXVValR1QzZJZlVUYlM3MFMyYzBzbmNleEp3?=
 =?utf-8?B?ZEQ4UGM5bUt1QWVxVkI5L1J3dHF2SGl5YkNOZ1VMc3kvUUhnME93VTVMRUFV?=
 =?utf-8?B?TWtLYW1xQllVQUlOR0tLZXF0OHJZUlpldkpiZlpjcEdCMytFbEsyb0QyMFRT?=
 =?utf-8?B?NjVxSSsxQ3Z6cFJSRWc1VUp3cmJJN05DeTRPdVprMnNqbGdna0VacmROKy9y?=
 =?utf-8?B?ZThoYWVDTXhSQUxNaGRMUkE2ZldhTGtSa3BhUVZCMVV3TG1rSWloQXNlekVH?=
 =?utf-8?B?K2RGcThtL0dLb2xxRzRJRmhEbXo1YmtSbm5FYUloUmQwR3Mrb0NEc1UyUVZH?=
 =?utf-8?B?cUM3OUdVTnZCalRUZVFPMm1lcGZ0SHJGVlRiemROVENoY0k4UFZYbUcyMEJu?=
 =?utf-8?B?YWh5bFpvalVxSHgwemEzMmZYYm5XRmtzS2g2dE4yYWlvMmpUVmZidTV4MUVZ?=
 =?utf-8?B?ZnFXYkxEYVludnpYanowVzBKcjBPdGsrS3B1SzlQeHF2Y1lMME84Z1JxT0Rx?=
 =?utf-8?B?MlcyWUZkU3E1ZjNNK3Zya1RhclUrRGp4QTJHY1JkVkdVSWR2VmNDcndob2VO?=
 =?utf-8?B?TXI5SERwbWZ4Wlo0dW1yOXVkOUk4VndxOXRBM1hoSll1R3dVYkRud08wN3gv?=
 =?utf-8?B?aStTWUJJWG42VWlObUxNeHJmTXQvZnMxNHY1TFRYYzFIbjVmTDVwYnRhOXo1?=
 =?utf-8?B?d0Y2SjNWZWxzejVYeUJ2QUJLVTZrbHJsbzk3Sy94Nk52ZVBWakJnWk0zbFlH?=
 =?utf-8?B?emo1VVJ2UytsWmw2QzJyWFhoYnQ1NXZHdkg5V2hrQ2lvSWJZSFNxa3Z4WUJp?=
 =?utf-8?B?cVQ5N2tHOWcrN2tDTkxlRWxBN29VWjAyeVovclpWa2RZdTRjVldSc3pJTmpV?=
 =?utf-8?B?dEJlWlFTQ0JVWVN5WDNmaUlDNlRMdDBhUnBQTFpJTVNRcXZWU1JWZXZKVFhK?=
 =?utf-8?B?V2d3Zll0RGdOVkxHM1dLY1dmM3RmTDMzcnUzQkJMZ2VJcEJqNmVCOFhIUFQ5?=
 =?utf-8?B?eVBqOUl4K25FTU5sa21xWnhwTHREZ01nY0JWK2lCTExOSXF3S0RaWkNJU202?=
 =?utf-8?B?YVBLUndYeXF0VEV5aVdIcVpuczBtY0NIRE4vMFVXOG9CaFRTaU11REhRM2xX?=
 =?utf-8?B?V3M2ajBLVG9tZEJHV0FXYWFsTnBFTkdJaUdIT1d0bGJHN0IrdllBSXc5d255?=
 =?utf-8?B?UThmZDBpcVBCQWdmRWNyR1hWWnZiRTdBWUE4eHVLMWFLRUtWQ1dJVFp0VUZV?=
 =?utf-8?B?NEhUZ1BUcWtLQndpUFhNSnZ5UkFIV3pCK3NpT2Y4SitZc0RpV1Znd2VUT04z?=
 =?utf-8?B?UExpcnlGeW9oTC9QWnF4Z2pXVEF1Vmc4dGtIeW8rS1VpUEtqcERJaU4wS3hN?=
 =?utf-8?B?SkJwQzBVeEJ5SzBwTjc5YkZTQ2RIVnlKT0RYakFsNkhkbTNQSlVYdTZaTXBn?=
 =?utf-8?B?QURMWHIwcFNidUVWVXBDUG9kenppVGcvSXRDMWJmYUlORTR6N0RVbVJPM2s4?=
 =?utf-8?B?RUg2L0RlTlNqRnU4bnhtN0sybWRHcE40S29JMStrc25lTWk3WEEwTzZkUmJa?=
 =?utf-8?B?dXE5MlloQ21nWE15SS9HcXk1SGtZbHBjYlMxQjVYMkJqcjNJQW5yVzZ4RGcx?=
 =?utf-8?B?ZElraXpUUGxuSlVmbHo2dEdYb2RmU3BTZ3orOHpYUURScTRFZlJISUMwNmhN?=
 =?utf-8?B?azQ2SGdBZ0lrd2JESGdIWkEzbkowMHpVNFYzZU5VbzVTVXd1eG1nTktvMGc5?=
 =?utf-8?B?N2t6ajdiODIwNVQwNjFobUt4eUxJUXhNemRyZDVORTJKSmVQMVBsVkxuekZ2?=
 =?utf-8?B?THptWk1mc3hwY0xIaldqUXJTM0FzeUlTTXZHOURDZzZEL3g4UDRobGZ1MWc4?=
 =?utf-8?B?ZmgvdlFVZ1E4SUgxNFhvNTVqV2lQVjJXT1J3YWt6UWdhQUxxM2hERGhiemxL?=
 =?utf-8?B?TjBFcmZxOStaV0M3RzdOQnV1R2NrQkZKTGt0cWUxRXBucVYralBvVTdub3l0?=
 =?utf-8?B?U3paTWhFSk1IT2cvUUVBaGxjVUtWWncvc3VUdSs0OEZvblVHeWY5RHdzVG9t?=
 =?utf-8?B?MXRKbFViVWowbGdFSDJqTFpTUWErVUJyREJmMElCeml6QktNYk4zT09wMCtn?=
 =?utf-8?B?Q0JUdmdQY3E5cVBSK1NIcHZVSUhVbzMrZEEvZi9IMGJtOWg0YmxUZXZkZDNL?=
 =?utf-8?B?emRyR1VxK0lKVEREdDMydjJBQllUM3p2UndmWVF5VmxLeFBzK3BJT2dnK1ha?=
 =?utf-8?Q?v+LTxrZ7clwFw4nqs46hMWfSnk+J7x9jGo5Cz+/Hxs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0A67CBECFD89AC45BFC73553C66A86AF@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Qs4stiom5fNU66I2evfFMSRWwXo3cuEKWVxxi9o2hvMFDUseLluBdE2gCgUPaVonHsHre7URBQQhEAxMn2X2hsKbhHq9q86pUMK8+wmkNEdcNIWUNe0uEJCQmy+tRULdwMw0upiLQ4sWgkQvJ7lkclFQxUy1SEYc6I5apwrHZIMzRIn67UJaljPsj7YZlJLMZRuETr+Tc5ZucfBMP3lkg2Wbkpiq3n6mCHkXtp2/BxJOFmP2ymeInl/MG/zE2zEfTVXFbDvsSYXONlIbnc0TI+ROfnH+2fSCFkiffu/UvctOvdmWQY3Zh5+1INWhNd7Kp2N/yXSVpojCZE9C//Q7YSCKmL2HgGSgId5w3m6IKqnKnD3D9p5venmkwjPtuUhNmSdE5+5BbONKGqLzkRPpUdEK0LdACxbQyt0RsjsfGoe1v3gbCixc1BFmM1SUEKOWIby9sS1WiQ7anA4gAnVXjUtS31f0YFAOwWFB841Evb5I3HzBbcEnmnj6MR1fZiEVhmSbhBwHpH+QNZrB1ej/pte/4h+vDKeM5k6g/q++p3ILjJOHVYfmSIP9WnK0PzP7otIUrsWZ8B5BbhzaH+bwLU7qiFjpEGFa+v+PlaFekSWtfTkZsouTPpuTWkP4jGVV02BZYJr449WfItffJhJl8sGprT5YSwowFnhtSB+7ETuC0J5o6aAwVwkSkJYD5+KTqbU7CXnnPjGXz05/TFu/hGj+q5pbodv8o7Cp3KieIWFmML7CC0ARKXEGNH6NbciRndCFeM+m4PT7fP/C+DnvZtFFTpiBaG9iXZDxHi+5RKhdEBQFZIVWzolodBcWsQ7cntYy/0TXF7JXqgjTcwovEGjZxiOgV7xf90itRn43xO+qaaSFDXuK0SQYHHudUwAP
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bcfe5cf-66b5-4c92-6a20-08db15951ae6
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2023 11:57:14.8050
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C/Irkk9zJ9tsqXHve+AAVDV8Huuo2PB7VbGjC0Z6nOCfwlCPhQPMwhcOS4crLPGFr+11phhHik8lo/AidX4Yzzk1dbsn7pyUKNXU3N+Iq7E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR04MB8678
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
