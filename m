Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 454337110F4
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 May 2023 18:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240896AbjEYQ2M (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 May 2023 12:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240909AbjEYQ1m (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 May 2023 12:27:42 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B4610E2
        for <linux-btrfs@vger.kernel.org>; Thu, 25 May 2023 09:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1685032037; x=1716568037;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=aXz1NDWeF6pFtNf91b5OiwIoRiGzPfJSIzRJS/B8DsLKMvubyM7scR6o
   siQ3+JsTmpf7OVTYUJ7gd8FScQ7inaafYr/Z6A8gbVWoQPRPqmwBS+Tdx
   Obrqz3ZFCIGDCI1OQzi48e5Jyzk5KzA5k6AUu6HsLd7Z9sVpxZVW7UIsm
   jIbOF9pONV0HRhtbDJafE91mI4uMxvafXw7GdPtcfOYXZl1F880nbDf6W
   ZDrfDrM8GZeyt5zwsTRwiIRhybm2D72adpdBcJZ+naCK3CcpkJ5fGyUzU
   bmbHZDGXZEPbM1RLx78tANyZFJdUKC7vozScZ6+VJSyojFm9MOKiJiBVB
   Q==;
X-IronPort-AV: E=Sophos;i="6.00,191,1681142400"; 
   d="scan'208";a="336119434"
Received: from mail-mw2nam04lp2177.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.177])
  by ob1.hgst.iphmx.com with ESMTP; 26 May 2023 00:25:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GNOc16ktNlR9Vm42mpQpy2/jykkVAruLWEajkxA4YLjxUmJNpb4vuqEMTbCCaM87QwibZmtgk1KpADV5i1FDJWKGEnEkRVS+VTkgHHnHYDnkccOBq9oDDlw+Wbi09Le1pqpsQNv20UrcFf3oAq/CH5g4XgulERZcLLDLVlaPLwOobq+XXCvPjPtCPVf1qFc/ta9wAGAH7FM0oWjq8AHwXKI/54ZI92sq6DGNs4FlS+K3P2WKfcDrgn/IEevhP8BCHqc6MnB84wkdxRa+rtg9oUbQv3U+vWtPY4X9eXKgetnsADDAEjHQrfTqn1EFZCBULoOMJOH/6irvGJo9N0Dnxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=esWp5QkZmpuodif8hK8LR6n2PBg6hKtWRI/7WP7u6hfcAI3GQpaFSJCXuvumVSP64sXWAFbDHc5PazldZjpTpnGi3AvmFCmmGVEc0M6EgCMxjVzdaqb11LdjycGNe05NfK08pYJLT8GSNwW1pHhWYmHRGjof8yluPB9Utnn1cUjc4EVC4IJAsi3mjo0c+J1gNzQcfKnriduL1qeME5nbWF2Du9PF+jy8DnEj6UzCO+tRCZAT3MvtRaCKICyP84CE/Cy7zTAT55kxg0YkMW6yDiVP0icwkKyQcLAf7X2UyC5I7OzRmEXrMXSa5LIV7aCn33stHgoOdAisX+rjD68NlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=tnInUYUVqS3OtFvgJdGYwkomUnK6QcalIVWFgtcGWCs9irDyHMtYsDomNCRBZlAO3McwsGrpvpJKfWvFhEkI0NyEB1vyIzF7HF1ZwMoJfawZeeTmyHyVhxhRHk9cTur7u8LJCcJRC2MCURtOlGfapqAgley+AJUMfUfR9CMoHMc=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by IA0PR04MB8787.namprd04.prod.outlook.com (2603:10b6:208:493::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15; Thu, 25 May
 2023 16:25:44 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f%7]) with mapi id 15.20.6433.017; Thu, 25 May 2023
 16:25:44 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 13/14] btrfs: defer splitting of ordered extents until I/O
 completion
Thread-Topic: [PATCH 13/14] btrfs: defer splitting of ordered extents until
 I/O completion
Thread-Index: AQHZjlEQ/fUa1TZqX0mcYdeeDDqCo69rLnkA
Date:   Thu, 25 May 2023 16:25:44 +0000
Message-ID: <d4a96149-1d43-be66-303c-61db195de15a@wdc.com>
References: <20230524150317.1767981-1-hch@lst.de>
 <20230524150317.1767981-14-hch@lst.de>
In-Reply-To: <20230524150317.1767981-14-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|IA0PR04MB8787:EE_
x-ms-office365-filtering-correlation-id: b5ef2208-ddc2-4f43-e366-08db5d3cb0ab
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iuyele1H+8McOUaoeP+TU2gvxMWAJHoYZZCoh4iZmGDCJnG9oo1ExA+bG8UvIssGdGUOMO0EeipZGSExzMaTauWR2Div4TGau1hWBSjYIUO1N7aNjvGV04mXEU4iS41OzeQj1R4yXiU2oM0NqpUJvZGdS97xitYOvGGD6VSqE3xscJdAGtor4ktRdpaFp5qQ6Q8nvMtWan/6H5qvK2iZ9KQBqFte7feHkgVlG5zHzqxnAeIdnXDjoIu4LkXFk09otf+Dzb+YKRgjcEz6MLEtV/u47w4r7tF8W1CfvGSiI0tEqq5B8xTpOAbQbrfKpkxw9c3tjBV7f1xsJwlpI7FOY0usxg9tqO4fkCO2X/KWFb8qbq91JhqoeDBQ7zieKp5GRH147hZAFRZlt0Wd5prUjPDXjTkvQbd4bgxx2AbMqMZZ6MppUJ3UDQErV5KEuapOlSQ9pU3DA7SFQ2J5kivhrIEWoVBmeAxqiB1vMvmxSetrWGbqR1o7+0LgAIrsb2oGZC34JSRm8ECbHyYWPD6qiqJLUW7OnGylEVroyFkbr4HUg5Rss7HI70OJ3rsZWR2nqTSr10qpdz7EdkxsH3gks48C09gLCprn75mzw1aw/xSfuzSx6g0NTKe0c8oDNre+RXSlX3eN32gmfo8zvoHK1Hwn+oVSPkkbSQzGsdevsU7/iNcaV89nc5GQ53p5L8LmdInqq+lij/GRYvVkgMuGgsetkz49OHOH1/xXm6XFxrI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(39860400002)(136003)(346002)(396003)(451199021)(4270600006)(2616005)(2906002)(186003)(19618925003)(36756003)(38070700005)(558084003)(86362001)(31696002)(38100700002)(82960400001)(122000001)(5660300002)(8936002)(8676002)(41300700001)(6486002)(31686004)(110136005)(54906003)(478600001)(66556008)(316002)(66476007)(71200400001)(64756008)(66446008)(91956017)(76116006)(66946007)(4326008)(6506007)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K0phNkZVeXZTZFdxNXFSdXZMbjdyckJsbkk2ZlVFeVhJdmYzZFcyUEhxdnBZ?=
 =?utf-8?B?cWRGd3ViTnBIYzlIUGI4cmhFVGlqNmx4U282ZU5YK1o5VWg4VnZpeEtXdTRx?=
 =?utf-8?B?b2dqZXVZQjl2Rnk3cDVsWnZMMi94bkJZejZkc2QwUXBzRTRMV3crN3hCT0lr?=
 =?utf-8?B?NThmZG1JZDNZT1MwWVRzU05WTmc4NXlHc1ZleGVOS080YXJWdUtEdDJ1MDlR?=
 =?utf-8?B?ZWFQU21jakxCeFlxWS9uSjF6TmxVV000Q0o2MkNLQW9pWk94anhPV3cvdFpj?=
 =?utf-8?B?VTc3Q1pLMnE1MWJSYTdtK2ZOM09CWVlTanBieTRoeUVuZlEzM0pLNnVLRjVX?=
 =?utf-8?B?bXFvREVCNVRId1dvd3U0VzQ0RS80UkorUHlLQ0VSNFRPR2pnd2pTbEcrY0R2?=
 =?utf-8?B?RmErSDBmR2VpMUVnWnViUHdHSGxTYUpCV0JWOE5ERGk1OWd2QWk3NUFNeTA4?=
 =?utf-8?B?eXhmYXpaSFErOC8yQ2Q4enM2d1RCbkZwM3BUYnVsOVdwRVp0Z2hmNzlCbmRm?=
 =?utf-8?B?ZXpVMVFSNTB4RkE1MjlVaXo4aHIwTDVzS2pHcmJYS3VWTXFyL2ptTmlyWERj?=
 =?utf-8?B?eWhFU2tic1lDUmx4cTBEbjlzUCtUclVFSXRCZ0x1QXpnY3dGTTVIZHRwQVJi?=
 =?utf-8?B?dG1wMTVkMGJTQlMzVkFRdU96TjBWMFZRQVZxZStTTkEvSjdweFhoV2FocmU4?=
 =?utf-8?B?dXNxd2tzS3JRR3k5clkrN0gyNXVjUnVEazdQbUVSY1craG43Yk1RNjdXUS9B?=
 =?utf-8?B?RitQd3kzd01ybEYyRDRzWU9UN0RJWFh2V3llL1NYT1ZxUU1yMjIvOFBpZmRp?=
 =?utf-8?B?M2lUUXdqckhhMzdZNHVMZEUrRXhyUVU4aEdSZ1B6eGU5eEZMNjNhK3pGNzYv?=
 =?utf-8?B?cEY0UVZ0R2VyZjhjMXBSMkVqVVlCeDBKZ2JocVN3dVdCVUdxcUZNZkVZTWd3?=
 =?utf-8?B?YVIrblUzNzYwdDIxWXlJNmN6NCtodWxrUGdtZEM0dkwxZGZoUGJuTDZSaHA3?=
 =?utf-8?B?RG9lUkFDdytwY0p1YVk1N3N6L2FhazNUd1o0T05ZNEljN3JJWlVRQ0hLUlFr?=
 =?utf-8?B?MHAvdTVjZU9Vd0lQa1ZJMlFSYjBCc0JGWFlUWEx1N01ER2xFWkh0MFFyTVNX?=
 =?utf-8?B?MXVNV082cW5EanB5VW1IMWY2MGRuNHdxM2EwQlo2aG9JM1hHVjRWd2ppSStk?=
 =?utf-8?B?K0VscStqWWlNejNOVUJFT2dVa1A2bHBqcmlFVmN0cW55MDJCMm83SmRMSGpI?=
 =?utf-8?B?S3BFOFlGNFpTNWlxWmxJVk9GVkg5c3l6NDc0OE05aUpZbW5jYnBlNU0xckRo?=
 =?utf-8?B?czRNS3UvdHQ0NUxLUkwxcHJVdkg2UFlhenJUajVXZnpuam1OUUdZWFFUWDc5?=
 =?utf-8?B?aS9FSFZKcmlHVEd2MU9mMXozR0dHTUZ0aTlCTXRZS2o0alVzOGJwL0MweTVR?=
 =?utf-8?B?SXlBdDZsZUkrKzJvby9uUXBQODRCU3ZlL0ZOK3hyOXNCZnVEMVNqZlhuSkEw?=
 =?utf-8?B?SjJlVEhmQnM2cUViemFtZzQ5ejc2UWNKQzU3bmREN211c2dCZm5NTGIrU3Jo?=
 =?utf-8?B?NWtBdEVuSXNMR3kvV0FTb2lveVEvQjhwRGZlejBkTGtySWFQMW1wSSsrbFBC?=
 =?utf-8?B?MU8zMXdXL0IvSklSVmpxTEduMDJSMUFBMjZPVVZOZ0tKTlQwZ2FRdkZsSW9R?=
 =?utf-8?B?dW9pSHo5UDl0U29XbVZYaWpzbHBoZGYydS80OU9VYUZWeVZMVHRUa1ZtRWph?=
 =?utf-8?B?TFRjdEFuUm1GUjI5M3JXeTNXMU1TNS8wM1p2MExKYi9paFh6ZStXUTRESmxL?=
 =?utf-8?B?MjZYdXdhdE9FdVEyK1diTUIydGdpVDJvTlordlhXWDhTeHFEbVVjdlJERExD?=
 =?utf-8?B?YVU5My9UZFdXbE91UmN4TmQvOHRiKzNDSTFXTHoyRUN4UXpRRlJJTU9Bd1My?=
 =?utf-8?B?QlNSRXFXbmtMUjM0bUt4TTFpZXUrTnFGbFhSdFNvcldCOVhIM1JzRm9VRzc3?=
 =?utf-8?B?L1VMNGlCTFJwa3BaYUgrZjl3b2VvUS8wbnQvanBhVXNRdWtVUlgzUGQzclM5?=
 =?utf-8?B?UmhaTnNzNkhQR1NZQVM2R3BoTmJTUElBaUIwVmM5MHF0ZHIrVCtJNUs2cVNv?=
 =?utf-8?B?UmJURDhVNWVVbmNDaDUyOUVlM2k3NWJQNFdMTlgzc1FEa0pFTG5tRGd5YVhM?=
 =?utf-8?B?VDVKSFBIZzd2S0lBN1VHb2hUVjRKdFloS24yOEt2Z1VubmdZM2ordVJsNlJk?=
 =?utf-8?B?MHdQNWFFWHd4SHc3SlgvaHFmdEdRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <57040F93BA2F0E45ABEC01D2DA825349@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: I4dhBY/CWYvTG0yZ8OKFgi4/6DUDyHqCCN658RNDeOhkpguoc2oMJRiCXiZWA8Qb5FpSENSbtYvyiREJ6ifPMeFMhR79L9VF6WQcVE8uRETw9YR2w2hg8gXgPZ8T6wJ66vgrsnTosFfZtqxxvu6ey/d5SqanvdYr/GWksdUPK1T7iatacgnfONB2wT/+16Gb4Zm1d3RC521ks2Nl+GKlafLi0LWDpNrlpweL/z72i2Vi1kWEx1orh6v+4zJg+WU1QcS+xWSZOuJvUCQg22yCFOWR5XPI/S+m141EUVU7iQ9HB4BVQZFkXVTQG5Qn86HvGFTpNC/hQVQiEJLhLa/glJR9S5Wp3QYK+IpMSSBC/380RfW//dK3NNq99gvZe9QjzoKdFXOguyBllHYwha8MSTLShg/+4I6FYvYPFZwo9HES7p2EDO2DEoWNO8/D6kyppufFh4hOgSwYigA3UJNU1O30AQA0vOwCPvP1mtaWRQNu3aDZVIy8PoMUoD3XJmdGnbBpm/2e0DZ+/z2lIqLOIdwe9tNQOXVBLiGvk6iiIp4jcef+GYTKYstqq8Y7UJAPAzYdiO2ypRUwHpe8/Ht5BVKbzEWOtw9S0LjPteLdgc6cxqxJf4an1Ex5cnhDvnlf9EO40qrx9mXmHDqSkBiIwyIs6QCjiHPLBzK341GcsEDcuzVxof+5GkoRREcMvH5+LXijm5o13pYNsZC7T+Q+m9egx84X1BhoN3yW5t2eP3d1Q9gIcVcywsxOHJBThxQHAIYrPfx4hiUtkebGJYxNgiuhOnvTvYbEYtc7G4ijGFNjn4IicRTUxN+yrxm8uq3EYbvswqK+KEb+uzDn4kCCQ3DYBUR294NvP2pH4uDYCmhvsX5sq8+T1mB6kF1oTMbG
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5ef2208-ddc2-4f43-e366-08db5d3cb0ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2023 16:25:44.6525
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dhezqUfj+hUlkzukw0GZIh+LE3/D8E83ydQUfREYRHU8ItEN9BdfEAi3D3bbDHosnksbPhL5TpaCWjCHqjzRAEpG68NqgL4FtkrFYkiHQJk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR04MB8787
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
