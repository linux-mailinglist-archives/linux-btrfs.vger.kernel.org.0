Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5A256659E1
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Jan 2023 12:18:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjAKLSm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Jan 2023 06:18:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbjAKLS1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Jan 2023 06:18:27 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB12264DB
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Jan 2023 03:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1673435905; x=1704971905;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=IbIQSMGPEfjaCQopUznIbXD4Gd9j6/2t4hapeRe1VHo=;
  b=HMEyVGmxTpa/qndpvdjDjZ3AV4bv9Sy2rjdIqgLT2qbZduCyJfJ99/AP
   zntMBxK1H6yW+SPcUSNjtHpWkLfrAHqEOymsI/GD7dLLsT2rCy7/6Ud6a
   LE8Xc77jHbtZP7g7EsJCkck+/SM5HcyCPovEfjl48FwSxhIfH6BrqIVnk
   dUcf2qf0jL82Kz0WxyoEA9UY8JOU0OLA4W1vjJnGgMlzGSV7bosQXeJQV
   9vyc8f5EZbD6kYDReFYLD9nHTzAtBE8p9sXPlY9nt/K0lZdyXYC/33qjC
   c4EqdnZuK/vEPyp5WGDUxnG6OFBV+u762cUkwrk+zLoTTlxGIW98x4EZ0
   w==;
X-IronPort-AV: E=Sophos;i="5.96,315,1665417600"; 
   d="scan'208";a="332531644"
Received: from mail-mw2nam12lp2040.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.40])
  by ob1.hgst.iphmx.com with ESMTP; 11 Jan 2023 19:18:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eraS+uWHUEr1KTZMBMfI9/nlIfbbw5NjhesnZuwzkCf2Dj14ovL0ffM89bXPVGTlS60aaOtyIgeRNYlJvzoXLjLlH8YXeTZBLRGJGZoWTm0e70+48gSzdJPVDtJDfS1HwQOcOIavWOnEsVthaCC5DdLc5TTUOgcODUQWRR/W51WhA7Xlly4i1Dcx/UQTHr5mzbHm0nPYh07ct67D4ar7eTjM0AYCbBu/AOR6oXnxQvL9SaaQPPJrMm/dYf8wxiRLkq+9v9Dr7YZHf9LlBNJtZIVusCnYRgbbRwni5/T2wa3bRm8AibtTUSKp4IzJG6hN1taLTdFSx0Vz2a4S9rNaoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IbIQSMGPEfjaCQopUznIbXD4Gd9j6/2t4hapeRe1VHo=;
 b=EuiYAa0VF7XQaYaMaxYrBRHlCk2I/JjF+vZteOw+DFle0lxmusenoR01PaYNaTc7iP4BSpTcUSI9VAJVEj5qLnuqiDm6VYVugATOb/MNXCKhIhvtnys/1i6mfWQni9sQ1gqJCL/DJwet7c1Wuwi6VL5UH/BM5Y5RxJCF2rbnNtJmiUbUsgPU006aUrZNC4FYwLuMnMHUu8vQ0m2T8Ih1mDkXXdxmezRu18kA03FfghTkZGz6HUqNAy0EWIFDcVr5IsayS3jqjz37GbPQy3if8v0o3iYdpLHu1sl0/NAst3hk4g5fWG0gze6VFJoWZutMBEKtAMTDisBdInqW4L0Z2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IbIQSMGPEfjaCQopUznIbXD4Gd9j6/2t4hapeRe1VHo=;
 b=h+feXAvTmoKu4lrs4AIAnP448mju3RH/NgY14c/bV+m5BEujKp4YJQfQp5o/lcBLLcNLLK+Or0l7NodBaLQbIHt0xU5yMCQyjRlVC6JFWhwAFZCHDrjQtcixMfejz1UHz0kCDALO18e1pwTpiOD/CK+r1VhpGQvtuAWIMM/G/vM=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN8PR04MB5969.namprd04.prod.outlook.com (2603:10b6:408:58::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Wed, 11 Jan
 2023 11:18:21 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d4bd:b4ef:5bff:2329]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d4bd:b4ef:5bff:2329%4]) with mapi id 15.20.6002.013; Wed, 11 Jan 2023
 11:18:21 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: small raid56 cleanups v3
Thread-Topic: small raid56 cleanups v3
Thread-Index: AQHZJYVeVPLX0RtggkSxLUZ7E0i1366ZEccA
Date:   Wed, 11 Jan 2023 11:18:20 +0000
Message-ID: <9515176e-5dda-3408-4295-73f5206509e1@wdc.com>
References: <20230111062335.1023353-1-hch@lst.de>
In-Reply-To: <20230111062335.1023353-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BN8PR04MB5969:EE_
x-ms-office365-filtering-correlation-id: 39e894cf-b9ce-4772-40af-08daf3c58c03
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o9x2WMrs+4EhDL5DCoSgFzIeX3W/OGHezDJznXwhRdC08ABhAKm31fD5Eh3PR9I9JUBmR+Wpq6VXayUTLGXNpnu2eriz1MaLDEFBxRQxOPWIAXUKu5DREttquSkwrzcoTCvVojzomYzt31TWShL08EjtlL8FWoV8zxhd0eh6gmQ+WCrGBz0ZHB8egRKfBcJofsDrgK6SLTIRMp1sSs4E3GWlNgiciIKk5mgR/XZjkdU9+YlXwMrvQy97wvzCa+gSQStCDTa29dpytK0oDqulOAFzVHtSJdOVu4tImvCtTBjEg1dAE6hlgR+yQjuHeTIDM0hTgZQRX4fu1wHM3D5F4L4JgTE+ApwxLrFeYvQfn1WOozQjpFC9qrg44c5MKXcqNpiwBrpypAufcOnIG4+SvUxD5UkCFz5Gac4q5gYJ61sOooEDj8Zi1ser+Xj+ihMeay1eQTzAGTDmaIMsjGEwslBjBKpy5PW6NhqTH8GDvTZgGsCJ4IatSvc3mvSDv+KHJan5KY/O5RHpYVaqaP5Lz432Qs/Dh1IKUqBsKul4y9LUva76GG7XmUuyDrEbWtyFCXczD2OGsXqgQq1H2lG7C80HbK7UYkaDgjDEKBtB/FMegflrlUNmteNWp9jGwjKGe4eeUFWXGpENJZns+YHniJ5VGHS5uSsMAZKpT6TqsCZvP/hk9MP+hEOpN+pJpP04pFgr1K9CoVYmg2+mIAQ6cS7PAFGI2Akh1euY8bHi7DbyT1i0nfNLNILmqz0yo7969XV7q+qmow0RvWfrP34PNQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(376002)(39860400002)(396003)(346002)(451199015)(36756003)(41300700001)(6506007)(31696002)(86362001)(122000001)(53546011)(31686004)(8676002)(478600001)(38070700005)(5660300002)(6512007)(82960400001)(38100700002)(6486002)(8936002)(186003)(66946007)(66446008)(91956017)(4326008)(71200400001)(558084003)(76116006)(2616005)(2906002)(64756008)(66476007)(66556008)(316002)(110136005)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VHdpZHBEdmx5UUxzSERyQWt6dndVTmVzTkNiK2xmNUJBM0JiWlhySmVwcHVa?=
 =?utf-8?B?b0x2WTFVV0phZmpKZjZqRUZXam9PMHlTNVV1ZEtydm5FNkxpR0JNcktLU2FT?=
 =?utf-8?B?U25uMkt5ajZ0WStpZEdDRWVoWnI3Vm1iWFllVG1PTGtSVDRaZy81Mm1uUGV0?=
 =?utf-8?B?Zno3cEkybzBwVTlVb3ZSYWJVWVlpNktPREZtZktkSy8zZXlQYTR5dk9lYVRW?=
 =?utf-8?B?V3hJc1BLZGRFWjU4RGtuSU5QdUdnQkd2aE5sQ2NJeHlCellnbmYralJsUzdI?=
 =?utf-8?B?SVJqUEpMSjY5UjdxTW5Hbkd4SUZRUml5TGVTdXNkbGE0bDhhMVRrUDVMbnRV?=
 =?utf-8?B?Z2hkVm9UY21SSUFPelJmbHVabTZtTjdjZFh0ZHUydTFqMzR2cnBrY3kwKzNZ?=
 =?utf-8?B?bTd1MW9LWFkwSEpscHZIZGcwTStsNXh6KzlmaGZjQmlJUUdPQzBaVEhBWldy?=
 =?utf-8?B?ZXVRU29xem8rcnZKWVJpVzdmQTJqZFl3Qk1DNi9GVkhWTUdHSDFSVEVmc00r?=
 =?utf-8?B?ZTJSak9nNUhVbE1GTjRrWk9ENTRqTGRnYWpUb0MxV0l5RTIyL3YvVDIrdkRN?=
 =?utf-8?B?Qk8zZ0JpcTFONng2Mkg4QStlbnU3WThNbWdmZmNtZVcxRnpkY0ZIWDROdnc4?=
 =?utf-8?B?M2N1QjhuaUJaUThLaGo4KzlnZlY0TXM3b2VWNUhqSkRCdUJMak42cGhGTzZs?=
 =?utf-8?B?UW5PSUg3QU91bEU1RGF3Q0hIMHN0VVBwVE5OU2lqNHlRbjA3KzZuQnZocmRS?=
 =?utf-8?B?cGtHRVFtYXROYU43RFNyd1VIOEovREh0N1Y3bFM2cjNoY28yK1VlWlRwcFgw?=
 =?utf-8?B?U3M3ODMxVVFTdFFxbHE0L2pGSENhLzM5clZWNnc3ZFdlb0hDaDRqMjRNaW1S?=
 =?utf-8?B?WjZxY205Y2QwWi9zZitKanZPQUxLdk9Pa1E2dzNLT2NJTmprb09VOUV3Z2lv?=
 =?utf-8?B?ZHNVQ1FKcFpjdGRRTU8rdzZiKzhUQll5TWF5eFArTSt1MDJPQm1sc3d6WW1G?=
 =?utf-8?B?RFlFTjY0cEhyU3ZXbTFYYVVDNmpsZXpvb1RQc0tKZkpZTVV6Q0x5ajdoRWFq?=
 =?utf-8?B?ZzVVNG1VV2w0YTU0dzMvaUo5RTFLL2E1b0tqZU0zbjNjbXl0UUhvU1JGZ2NK?=
 =?utf-8?B?V1JiK1R4aHRGSmYwc2lLQXN4VVVMS05uWXFzMkZuNXV1RURiM3ZDRzU5N0Uw?=
 =?utf-8?B?QWhlbmpYT3FmNXQwNGE3VEJPaXFjR3hmUzhHSHVaSXgwUnJCdlp5bmEzVDBI?=
 =?utf-8?B?aGxlNGp6cEV5RS9JOUE5a2JpSnA3Qm0zeWRLUENxTzllcjZqK1VPV05udCtH?=
 =?utf-8?B?SHFTZ0EzYm82elBuTFp4ajFycEFIUE5mcExZeElvUlYxTTd6U0tvNXNzeVgz?=
 =?utf-8?B?MmdiVTBpUlpRQWx6TTNUZktOczFBblA4MGZiOG4vaVRrWi80S3JmbXdHWWk1?=
 =?utf-8?B?ekhDQ2NLNHJwclE1TG9aRk5ObUZoUDU5VmUyeDdIUVN5M0I5emlTbnZ5RVBx?=
 =?utf-8?B?K2pDcXpCNFd4Z0VYOW12ZnJwNWlNQ2xhd2t3R2JpKzM1L0JObkIyeTlqQzRN?=
 =?utf-8?B?M25vdkx3Y2JFaEVIUVA5d3p3Y2FuZkFwanllYXlFUVJKdmNCN1hEWk5JQXRN?=
 =?utf-8?B?NWlneFJJMHlGMW5uYTBCYzd0eHFiUzNhNHEyVGNlT1R2S21NdkgyV2hxRHZE?=
 =?utf-8?B?bVo2VEUxRklSalRVSlpwZ1F2T1JCSU5pL0lIK0F5NWYvZ2tUR2RwQXBHQ0Vr?=
 =?utf-8?B?cEpjdVp4K2tyQ1B5Y3luTWRTTnVvbks2M25xbWplOHpMSXJCWFhLZGczbU9Q?=
 =?utf-8?B?UlRDaTd3WWRUaWxoZzdOc0pBekw5Nk9XUmRBcUR6eFNkTTBtcU81UHVaNlhk?=
 =?utf-8?B?ei9tNlJwYlZlUmVXcHNCejdCYTN4NXFlMGhzRjB4T0czeUtIdjE4SWhPcjZk?=
 =?utf-8?B?N20ySnAvcG5Kc1NySXZkS3YwYzNQQTBPemtKTDJtancyT25icHVLNlNrVkRP?=
 =?utf-8?B?RjBtQnY2bGprRmNNSzdBbTZ4TzFma2krbVNWZkFnWmNZbmovRmZWSkFmNlkw?=
 =?utf-8?B?M1AxZWg2SUZUSjc1Zk11bWxkQXVRWDRDQUxpUnErdTVxYjkwZXFxMW1la3l5?=
 =?utf-8?B?TkwrN2h0VUtCc3NJaGV2cVNlbXNHOWlZSmR3SGZKK3Z0NkRET1Y5c3EvNE9S?=
 =?utf-8?B?bGRyOHJ5MVpWUnBabDZVNkJaWWhxSTZ5dWV5WkFmY1hldlFveEYvcHI2VVl0?=
 =?utf-8?Q?nrhJJh/BDKejs4K6hfM8NZM4fi701qv+dMkguX7obM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D05FD110C9CBAF448C33F6207380D68F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: T3/ocX+LdQ69rrkh1dorKYLOxtef56m0ZANlfRADv52vpEqI/FjMNdlOUm+7g2qXMoEyN+i9ByyN0kjuyGbYReD/sEWDUxrbVPnEcdDc2v3H57eyIqlqsNJAehWzFmuwWYwsFde3g/5VfXSKh3V+o2otKSgc1oGN9ZVr1hWXo2tg88yVW+7g/NSGWZcCOSdpSzFDvxxTQi2dmFbThvVr8IZ7rnocfwLw/CrtZntP3QshgAco4Xnd1ADmfCBpYnnVqGQXYLIGOlE+H42EFOpmCdpxTqRpmFulOGFkYP9w6YY4Xm/PE1hSxHH+OfUDxtJKQ/8cPxz7j9efVmnHqSbU5BDX1S+u4yjqSF++BnkgKgARfpNMtdzDo4FnmuFlZhDMqiyBcofptOt5HJnBzdrh+IhjuYMXCzGcj2GPGkWM+Wk/p0gzdgHUN2SY02zQdr61Ky6t/uowaljs78r9knrv+28+OPPXzz+W91SH3Da8IJdvRCCFrDKFGh5XjImdrQV+Yu2z3T8pmURFZg0yhGJqACVVPZEJX5cdDFEFLsaVG2GWQ7U62Jr6maaerAIPbdMOd3fnHwRvDezs2IimDKk8KxICA6TlyAbzFn4tH6P1v6L5r/6b3jpixIZo8O2B6m6cmP8qk9YU5jJIxnIMKXIZIiuvAFi3mmBiKhSg+IMfFckMXmc1JwSBvTfojPMbcrxDsavEe2xMLFW/OaOXB6YZ8Yq/KUHCHwPu5bhQL88Wm7MPss1rTDvlfFNY7rgCsmPl5l5W6UB4CFVcX9yiIxZD0t+2Jy9oHeCmAOmkt47Vk2YPbffaswg3QOKpX6xD3biX9i2/qTkxWjpj8jkIHg8q6y0DM5/7o+kcdOI/ofqKQ4mbPwQsZqukyECvflPoXJYb
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39e894cf-b9ce-4772-40af-08daf3c58c03
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2023 11:18:20.8851
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fUrNDRDg4DTqj7chuU8t7HCfPd+GX1CYhq309MyBp7cZbCEQTfub+ktdiXicqz7zkGGmYsocJi8sO5ZoyDjEbx6S+lQWXVpoS5HqtCSQAqw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB5969
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMTEuMDEuMjMgMDc6MjQsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiBIaSBhbGwsDQo+
IA0KPiB0aGlzIHNlcmllcyBoYXMgYSBmZXcgdHJpdmlhbCBjb2RlIGNsZWFudXBzIGZvciB0aGUg
cmFpZDU2IGNvZGUgd2hpbGUNCj4gSSBsb29rZWQgYXQgaXQgZm9yIGFub3RoZXIgcHJvamVjdC4N
Cg0KQXBhcnQgZnJvbSBhIHNtYWxsIG5pdCB0aGF0IGNhbiBiZSBhIGZvbGxvdyB1cCwgdGhlIHNl
cmllcyBsb29rcyBnb29kIA0KdG8gbWUuDQoNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hp
cm4gPGpvaGFubmVzLnRodW1zaGlybkB3ZGMuY29tPg0KDQo=
