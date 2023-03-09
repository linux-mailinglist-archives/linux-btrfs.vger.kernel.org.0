Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18D2E6B2AEB
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Mar 2023 17:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbjCIQiB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Mar 2023 11:38:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbjCIQhq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Mar 2023 11:37:46 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B2065C7B
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Mar 2023 08:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678379303; x=1709915303;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=LPJiMk2aZ8zd7hddyGgQQqBX9PtG2HOT+IO55sVjYct/QsmqLWHjUD7Q
   8meYkIo8XiGQm/3x/+BBaLzal0JNBqR7fTwU1JDkNnuxSlkY2d1yPQlM5
   CBz2lNywQRVjT6GUgFRajqZ3mEAixNli3dxJNyXKPO71N51Gsezt2kUeq
   5mO8Q+H12yBDhrlYn6beRPgRQbAeNyptNiqqJDabCuK/VszzcvebamKv5
   ORuFWG0aD+/gnvpbjtrk9vbVFAKzYxi0hAYHzZYFFjwWLHUEOLQM0z65T
   BM4NLYIDRG8uFtYG7kyJe3rvf6Rhqidf1DnhtnWTlNQyOhFW12A6LJDCF
   g==;
X-IronPort-AV: E=Sophos;i="5.98,246,1673884800"; 
   d="scan'208";a="337234016"
Received: from mail-bn8nam11lp2168.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.168])
  by ob1.hgst.iphmx.com with ESMTP; 10 Mar 2023 00:05:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TOq8PeBiZ2cG9l+Kn8c25xOP8N7KS8oxI2Q9SWgPzRqm24jbT7sjoqBqIiGObgsPqoe/zv+lDwywY1yIlYFOTpLLB2amIEvb+afIrtGiPbh/l5uEZMuov5y8fqD4zsoItT255fjbHO6pm3IRJrcwNfv4O5VgMo6zqcQGgUdOmQJIFmamcbZPiVhO3Y44+6UYlwtJl6GqaC/tVrytJCqSqeRl97fAcG5bUDHGWCBa3NZ5QGw1j/c8Os0a2nPfv+2HuQ89Xn4hLl9WBbJHTM7gNQTYn7f2bEkqSqOx4WcL5SbiVJOMlsDcngVhIlejjmSj5Ne4zjg9sZAJS3tOLaabTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=cj9h7iIgXTXN4I/n55ljII4ndpJnjYw9+rB5Sp/SRrJhoNCV87SpF+UhWmplG0a4u07Mhf9UWB8MQptUDI90tz1Au0Vf4xGjqsaiWmE3Am3d7BkCep3+AXZ/XpNQisw/HqF8DINabnQeAzpjlTJ3F53RfV7XiSNTAfG7WV2P4eWXl8oNKxCcmu9D5JusL5iN38mihsTZZUuTxsgJ9SW30DsWhfUfR997eREDR31BUR0y785TNqe1hHOmmcCFBEfLjjNJRtR+gSSwXsguIDxl4ut5TvDTVx8bDl3jcpvMWu8+a5eGpX/9oYYAypNtFkboPl8gAHCRQYFpPW3O1Len6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=m+iHsLfVJe3awWIG0Pff2Q34fTstUwjfdvLrIy41lko0euSUEdXrlKXShVmFwZHDTOcmBKYf+0xQJcn2sMcMuuBySo1AtBVIQ8SN1i8vv3b+Rq6d89E1QmdvmlTv6Y5J7wPz6Sq1IpNJUGM7C9qpoJW5ALGG98QuzpPR9Kw7Of0=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN6PR04MB0691.namprd04.prod.outlook.com (2603:10b6:404:d5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Thu, 9 Mar
 2023 16:05:42 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%6]) with mapi id 15.20.6178.019; Thu, 9 Mar 2023
 16:05:41 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 16/20] btrfs: stop using PageError for extent_buffers
Thread-Topic: [PATCH 16/20] btrfs: stop using PageError for extent_buffers
Thread-Index: AQHZUmatRAU+iC2RT0WtSeTntKQr7a7ynS8A
Date:   Thu, 9 Mar 2023 16:05:40 +0000
Message-ID: <73a8fa9d-cbf0-fe72-5f76-e70015267707@wdc.com>
References: <20230309090526.332550-1-hch@lst.de>
 <20230309090526.332550-17-hch@lst.de>
In-Reply-To: <20230309090526.332550-17-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BN6PR04MB0691:EE_
x-ms-office365-filtering-correlation-id: 5d6a1adb-7201-4155-aee0-08db20b8216c
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F4VUF7fNAHJdeM5ygWfu4x+8KPmyhCXZxXImNne+OWBxqBVNq/hQd0g74gPHGWkYIlS9zjkkgpT2ExRXIJMqxfmxHDHjS7ZGVqfvLLl7lJFK9i4P3vr6rEXUzO7Jb2B36BNl8dms8U4iL8bfaqCTSE8SJuUHAl0vAihOGDm88MW71RKIsDykg5e+91zWfWwx8Z7gbCiWr8FMLEWck9Ug6iNrXavgbONqeXmTIKdu0VWFh1qwsCL0QHlf9JS2z6FyfUNAEDTh3jMQsgOGXIGc/S8BAxhpP539AsHjHUucFbWZG3em5nuKGR00i1sfceEFNOHwskb8v/szGaaevFDjky5zGgYF0+zZYJYlmJ8bawR1PN23/k2n7wWHB/5w91cK7zeZ5DqGaxoDxmX8soBsmXQ9+g8Ld5je/Tov77GUZhKkGT/hRVNgITfMmBVf4o907x6nDHl3XmuwGm5ufnmX/pZme25bD5iYJAP8Ow68aZctPtorLuKmyggN0CypGID+z6/2hBqiX3JvLlBaTyL4zfNbj52oqDk24t4xXBmcB/OuCBWkYDbtPzPjA8y7+Ur7S1p3GGgnxTz6A/raLmBVHeos5l+FFD3sdr/B+MmVcsEkGiZo/DX/O1wLW/+sorja5HMKiXsCyh5fcU+uyb6O9J0ICY/ZWDsMU3t+c1HxJnUxvHMg0/9DoBhsl3RnkO7HzA7Vjk12jCUmI1tawhHBm7tfUqwQ/gyow4RbvltkunAsDT1KiT5HhvCMabEVJUX6ADGgkBnlZ/acZKCaz3HL8g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(396003)(376002)(366004)(39860400002)(451199018)(19618925003)(38070700005)(31686004)(2906002)(5660300002)(66476007)(36756003)(8936002)(66556008)(64756008)(41300700001)(31696002)(66946007)(8676002)(4326008)(76116006)(558084003)(110136005)(66446008)(91956017)(316002)(86362001)(478600001)(71200400001)(6486002)(122000001)(38100700002)(82960400001)(6512007)(6506007)(186003)(4270600006)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OFV3S1AzSytZM0dHMUp3MW1WTGJjZW9XUUtrMmpnSjZXenlCL3pyVnBSVlVU?=
 =?utf-8?B?VlN3QTFhNWk2clZMTENuRHVicTZCWThqMVE5Ykl4MEppRHZ1V1pEcWgwdGd6?=
 =?utf-8?B?V3lSQ0t4dy9hdW50M2d1OUdlaDc0dVJ1NHMxYnJjTk11bjJ6a2tDMEVDZnR3?=
 =?utf-8?B?OXNaNEhjby9EMXF5VHlzUFp4V1pDUDJJRlhzakVHTUtZenpBZEN4V1ltbVNi?=
 =?utf-8?B?MTNybXlKSVRPcHJYeEhkZnpiblpTRktmenNndXJ4aGhpa0pLdXUzLzZwcTNR?=
 =?utf-8?B?NzBrQkRnWW1WaFFkcFp3UFFBNkFnRlFTNWRSZjY5dkJCdFErSlNFbkpCV3gy?=
 =?utf-8?B?VE1QSkl6dDJHOWxuUll4OUhqbHZoMWYrczlGMFgxckZKaFJiNGY5RnlCQllR?=
 =?utf-8?B?QjR2S3JkNFhESERHSUN5WVA5OW05Z0tMaitzcWs4MVRjSnlDajZka1NXYmtG?=
 =?utf-8?B?cEpmR1pWVCtDMk5nL1MyV0tweU1sZmFWYkwxS3VpYXRWdkc4L2NQL2lRVWVL?=
 =?utf-8?B?eERlYzFSU0FHOXNGVERMektTMHZiY3g2ZmJ3Um1KOVNOdDc3b3llMWZIS0x3?=
 =?utf-8?B?TkEwR0R1OGtaa1pmVjR1UVFQWjYrd3ZmeFl3OXhyODVwUUxadmlSaDBrckJX?=
 =?utf-8?B?eTg4MWlVM1pkRlZ6Y2F5cUZydjBXWXBzYzN3WlVqNTA2S2MxYXNxc3J3Rmxq?=
 =?utf-8?B?R1RCQ2RLTk1CWnp4MldvQzRLSFZPZGhUQS9nYzNUQlIwTlk5M1RPciszTTBh?=
 =?utf-8?B?QnhmbDZLS2M4Y3FOaC84dDJGUU0rVXdDblRFOUVXVzRGSjg1UEpaWDhzTjNH?=
 =?utf-8?B?Ryt1ZngrMVpmcnkxaklkTGdlQllWVmJKVGVaWFpJVzFKOWE2SFdWZ0FpK0dI?=
 =?utf-8?B?a2t5bXJVaVgzNUQ5bVpmVVBKajhrOWRJYUpuL013MEdMdE1senRpN0NaWUF6?=
 =?utf-8?B?anRIbEdDOVFPajFUaFJ2cmFqQXhXTmNqVE4yTmN6UjNGckFBQXlRYU0wLy9M?=
 =?utf-8?B?NVI3M2JVU1JpZ1pQRVB2R2lVTFo0V3J4cWtzOWVtWGtQRXZvWXRoNWRLWGhR?=
 =?utf-8?B?WWRwbTZ3T1lzaUdIREI3VnZHd1dVdzhTZmh0VHkweGtWOXFKTlM1OFZHaEkr?=
 =?utf-8?B?ZjIyM3pkZ3Z3K2g5cFdidzdERnAvbmF2M0dvaGFrUGUramZYYm15ZXFrSm9Y?=
 =?utf-8?B?ZE1uclhoWjFKaGhSNVZoQmZ4TUM5elF0ME1nTStQaVRERzJneHVoVjFPMnFl?=
 =?utf-8?B?Q1gyT2hTdFVCd0JsaG45bzh5bGhPUnFpVzk2U21JMFNrNFovSlh5bnhlZzFY?=
 =?utf-8?B?TDZhdEYyTy9wM04vM3dObFUwM2t1MzBjUDg3SWxta01uYnM2VWtmcWdxVGIw?=
 =?utf-8?B?Y1pzZStpM0JBeDc1R0Rpd1RhRWJuQVZaK2piZTliNzh0TnZ5T3l2eXUwbzFN?=
 =?utf-8?B?Nmwxb2VobWxoT3dBNk1GTlRYMUUxNklVVFY5RFUxVlNnQnlIdFNQVU4rWFZD?=
 =?utf-8?B?alZwbjNJWDJEOW5udDJoaG1nUUY0V1hUNFJVSjFVRVNDR3hmZ2kvc0VURVFC?=
 =?utf-8?B?NU9zSHV2YzluRU15MHQrOWZOcmdrZzRoYWpIdFpHeExZYmFmaWp2YVlRenZR?=
 =?utf-8?B?OTNKNjM4bUhTU2Zvd04zVjZHQ0FVY1E4RURlZmF2MkJySElTN1UxRE1TKzJm?=
 =?utf-8?B?RWE5ek1tTnBHaG1BdUNKcEtiKzVYOWh3RkpybE9UZWJoYkFGSWVGU3NNUGFu?=
 =?utf-8?B?YlloMGtHWEQxdVJXQkF3Mm95UWUya1FJVTgyWFhZNnA2c01pajNqRldFR20z?=
 =?utf-8?B?eEdhYjZWR3JwM3NZZTc1bG1sM0JSakdHZGZjaWQrQ3RXS0E5SUtkVTMzdDlz?=
 =?utf-8?B?MG1ncnd0aGlQMEErc05lbVZVR1FxWnNOTFZza2QvMFN2NXp1M1VSbHlpM1Bv?=
 =?utf-8?B?QjIwbHlRbHIwY2NrdnhNYVFsWkp5TnpvK3FveTlEYlY2WCsvOHA2U3kzL1Mz?=
 =?utf-8?B?c1RwUnhPejNLZm9GZG5nb2lOZUlQSzZhZmZyQ0hqSFBPQXNTZUFTWmlJSlJj?=
 =?utf-8?B?OERFMHVBOTI3dWh4RW1ZUW5GeGQyTlJuUUNNK01qOE5HMWZDb1B0UC95eTQz?=
 =?utf-8?B?Vms2R0t4bjhkaVJJb1MwUDBSb1JkeURldU5YNjJpM1pMRmVIR1hENHlmMXM0?=
 =?utf-8?B?M29NRkVQTnkwSTRpNm13d20xdG5mZFFHYjhJWjlZcXRWLzBZWGhOMGwwR1dL?=
 =?utf-8?Q?E3Mj4R52M9zOl2QJC2ylCPcsuiog/CtXPGuhXAE29s=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C33B3AD42DF66C42BCA5D3ED944406E1@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 2+5SeYztkxpf+czxAKpFxtVkX2dOtb+/ylQVcUs7vDgsd+oZqOjvyTVtLUc4FAt9OLKeWqVgnYrCg5rzgnsgSq1byBDvx2WI+AGydfrATyR/5ZibiP5U0f+q4Eo32y7K6Vg3DMDG0CrEMHkL8SiTNTUiTz00jfwfPvoFCI1gk6ueNVkRZfBZqFA4avPbqEnFEDfFCo4gtI9dmYrxS2wIdGYgdCvQpVoovzHeSJSU+WnTcA1LFT9YVWaXY+Zc0muyd5bUkmFdEfWLH1nhmi3EzA79nUbrvT3YqvpaDI7vYKfyWYB5XK8NtDDnGCH42B39YzIhkjfYIMoK2sFDyQe8H5FA8qQ7yFPVRAAFpE5CVTbcDlqpuvRVcTWUoSdtBBmnEba23ssQ8LlX0Tq1zFFzHE9u9s/dyBX5XKGlhMhldc/w0ovVAZE0OB7HJ1MMwuSXCaWMvcJ+x8tiQzuosMu+eweutWQStLv9zMnmHUwW5YIVMJ+lDUiT8UNCaeQ7eY7/QGMdBjmnMCi/FEl+a7ww2ss74CRv7ImVnr+JWWZzcohD5jbcQpELHasRo4iyWnNdmENThcyQxgpIoAOiFPwl3QnmQkje1MyompBp9EMaX+xXxKYwjxyb0vm7/kImjpjzBeMpq/Uc251wwqqVidGSu4TsOhUDFWwxfFx8SAKxeAaKZ9wgFzWVUMNI8g1ftSkLlXsMZQ+uWe50R/HFY6LrnjzORqHx2iwNCXzqmYRXuF5UeAHM1dgQnabGNLg4LpMtJE1D2l6jqSiF22Ll2MMN8l1Ii7VIDdx5S4/83nFCyxb45mtx8HD/m+YUHqHiKyKn0+KOyNKYzRr7PoHx+xUq6s12OjXwPNW3smAAsUBLwhfgnZBII3bhhOs0NVrJhFZo
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d6a1adb-7201-4155-aee0-08db20b8216c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2023 16:05:40.9430
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8+AEBPb3kJysr2Ch1vXvnToHW+W9GXHLdkjxA4nZ6cTMzAbO3MezZPAkMRGuIzBxDTwo3+AumiwkZIT7uGgi3TiR2c2uOgakAVcKuaFuerc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR04MB0691
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
