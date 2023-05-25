Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D290C710A66
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 May 2023 12:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240813AbjEYK4V (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 May 2023 06:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240569AbjEYK4T (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 May 2023 06:56:19 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A651AC
        for <linux-btrfs@vger.kernel.org>; Thu, 25 May 2023 03:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1685012173; x=1716548173;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=k2GCblFlTAdCn/Zpn3qXLUID17n+4w9dbuBGeZ5xl1OZuvhYTIj7Dvfj
   XXCC7iYwkWy8mDnLbGTD0oOJZqP804z6MQGn91t7sLqxnDC2qRwbABJPM
   N0i1XbOJZ96P7c9JszTB/JNhahm3PmfWhkyHhLjb7i37g3txLhZLHStjk
   BGm4gZQPcNGEP5VhqHFk2PjkxMZd69EkBTdnR4QLQy6xiu+eFouQGBuMS
   RI16lnX2wg+ZhNx66k++1K4/Pk3adwUjerAslpyPODKsgC2csoDF2g3ME
   2XnwnjcE6fbZyopg7E+fSzoiAYrLjflvZ6hAgGhtGqbGYlYa7XKoB+GVV
   Q==;
X-IronPort-AV: E=Sophos;i="6.00,190,1681142400"; 
   d="scan'208";a="343713004"
Received: from mail-bn8nam11lp2168.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.168])
  by ob1.hgst.iphmx.com with ESMTP; 25 May 2023 18:56:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AHk2CDghGqzOJct+LQ5d+FJ3cLH54n5/D+6DRjxzTmh/gX/Ez2W3KrPIGlhzmImOOzeprI50WTqR29xPmnB7yzvhG83zxIFPW9Fgu1Xmc4iUPO7XBWG1pQ6qyryr03yiXbDNHkDpvCct+8l90xoLHBODP4sv1tSh1wDyOTJdw7/1SoBKhBcyVKgI+rbxxrrBJsVlCC/QDt1WuwZg4qV1FephzbUnTGqebI/raRYZp1IqKr0JcWWPI1teoWwFAxranl3uBXwipykiDZILbpoexvXJeeqYMUWXR3m13g1i12XJD/YdY1KFJGiSbEVM9730jAoXkUbmvsGyVtKW3LisFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=ZiohO18x3f/42M4eqAqhwDXgMy++x5uTJlRc78WVOD1MKyUS/Ulyej0VLnFY4RXI7vFpYE86ymGfNFOtEKT+QtM/mQDuYDvjLca5mxoxfeplFjBtOX0ae+4FjaYWN1K43U/ZDhNoHifGRiDuNj38KFaHq8TmwNGZ4CK8khFGh4YHDpTVJTowDzgK3tLPbndMEhi9knsBpqAeIBxy0TCG36IFgd6ibwkSpOfvSDwDuqKWugiVQQY0MOnhCpifEWedfSJjL5DWgF6EopMU3p+e8MVxUe01HGI5etYAGzPm7Phxj7I29bzGMlkjYpIHyEgt3BFf3Ac/dXqmLTE/AWc2SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=jY3mYPdEZqtplZ2+qJyWUljSuXdBUIxiULFt4TRj95yuZ2eyMOOi6NKsgj5VF/s3T+xd9AEx2hortP2xiL2KVm5dhdLBp3ixk2QXBO9urbvl9WCEMkh1MiBNFKVmF9tP6DggeJhVjItqW0mP7/z4Bdr+WEW0RIwQai8+120+/h4=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SJ0PR04MB7613.namprd04.prod.outlook.com (2603:10b6:a03:32e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Thu, 25 May
 2023 10:56:10 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f%7]) with mapi id 15.20.6433.017; Thu, 25 May 2023
 10:56:10 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 05/14] btrfs: optimize the logical to physical mapping for
 zoned writes
Thread-Topic: [PATCH 05/14] btrfs: optimize the logical to physical mapping
 for zoned writes
Thread-Index: AQHZjlD6eshpnlpoQEi2DT6sVnuToq9q0mSA
Date:   Thu, 25 May 2023 10:56:09 +0000
Message-ID: <b77fb12e-dde8-5c51-f3f6-e51afe2530e1@wdc.com>
References: <20230524150317.1767981-1-hch@lst.de>
 <20230524150317.1767981-6-hch@lst.de>
In-Reply-To: <20230524150317.1767981-6-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SJ0PR04MB7613:EE_
x-ms-office365-filtering-correlation-id: 79b66968-e99c-425b-bf5a-08db5d0ea604
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KTPQTf+Ne6ncMSNcfkDyR7Hs7w1g7wPGwd/sn6NwEoNEBSVgRP7wO44AVG9dnbYmRkMqT991ZadQ3ZapY46XV9YyCTq+Pv9TaHDEIMBRRgFxxpJU9XK6+qqrRJ4FsBiLguGKLQn4Pz53ZPW5TIrCs8R7vUtl4HEU/KSeHuKqK8td4iXhRsC9aUmJVMsTvyKMBfxRoXayQD2TSf2CcXqgILFN6X66a2VXW5sacA9kjnerai0e8AbVYhqItLl5GmwVrLSAUK/1DTVfoUYgQXe6HSFf29LMw2oUWcovWiK8RI45vuD5ZluLdTpskOezrzCIyuR+zVlgRw4lyyXm+rSYhdGpg1Dm7FtJy0aYLKRAjpRhiTZu54hzikF8PIQfi0C2VLPsDhKbsdy0lWI4szg+rwPA3OkI4YT5XNCXLcR/2r4VyxVcgm/98nfgJqvSYHrtLd2OsEz1At3VnBaH/Ke1tNEzr+QjNmZMBxrdMCsk77WCSKK20pYJDtGkwjgKYcgYxSFTeaObgFJm326+2/tuml/DKC+pj5FESgojdXBL5ozDV0L1VEHVf6BIHRcZKkEL41nSdZCnUoHXK5+yHmcMvJd/FOGIJH/8c+3k38t62ZpTNeEYsryD97LWalc0o8sB7Lukh9dsRaDbbNxxA/4a444dewe10xqyKXIEHwMn9lx02wQftaDOB+OIUYcxZs0m
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(366004)(396003)(376002)(136003)(451199021)(6512007)(558084003)(6506007)(82960400001)(26005)(186003)(38100700002)(122000001)(2616005)(36756003)(19618925003)(4270600006)(2906002)(110136005)(41300700001)(54906003)(71200400001)(316002)(6486002)(31696002)(31686004)(66446008)(66556008)(91956017)(66946007)(64756008)(66476007)(4326008)(76116006)(38070700005)(86362001)(8676002)(8936002)(5660300002)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MHhGZXQzMHZSVEFvQ1B5MGVqdnl6cnMvUzcyZTdnQitDTkh2Z0hsc3RvZFlM?=
 =?utf-8?B?dUhTc20wNThZNXlVMFZnUjRpS21DZGs2QW9EZGFoUGp6V21JM25ma29JYWdy?=
 =?utf-8?B?MGFMR2JVM0ZDOWZtVGRJUVRwaUtFOVdDQi9YcnpiVHVrNU8wbERBMUIyRmww?=
 =?utf-8?B?YW83Y0JyRngyMjczSFd3SzNwWUlTcDdkYUhlekZ6Ry9JRHVVZzBLUWQxV2xk?=
 =?utf-8?B?ZzNBTjNGZ0tIQXdHNUdCMWRPYUhYakNWVnJ1VGZtczIxQ2NRQzFzeVhZVm9H?=
 =?utf-8?B?S3B1aEZoSVlyMHJxeXZUbHpzTnEvdUpVempBVGtEQ1ljUjkydFJNUSt0eTI2?=
 =?utf-8?B?dzlRVzFyc2ZhRmlIUDBSWGR4VlJEQWswY1BHQldiYTNWZ005dkt0Sk1hejdO?=
 =?utf-8?B?Rm9JdGFCRDEvMERDaGxyakhBb0lFbXVMbVhhRitua0ZWd2IrVmFrSk1GVFhX?=
 =?utf-8?B?WlZqWFBEZit4d29oZW5TSkxGei9uNDNvaHdMSnBXbS9WWFNYS3cyN0Q2TlFX?=
 =?utf-8?B?Sm96aGZQRVZQVmVTWWl4emdMM0gydk1EYW9xSWx3emc2dDhubDlLaTl6ZUFV?=
 =?utf-8?B?a0M1OGc0bitnQnhxOXdUbGsrQUNjbGlDY0FPa0FzcFB5c25qeEZicGoyZEFK?=
 =?utf-8?B?ZFlGN1IvK1ZuRGdPQzJ3M08wcFc0MHl4T2pVS3BSNmJFVDVFb2FZQzh5LzZP?=
 =?utf-8?B?cEV5RjhJR0xvVTczT1dCQmpkeC9xNytac0JudWl5ZENlbEE2UloxbVgrNEsv?=
 =?utf-8?B?N1RxRmU4NkkzandLZnhXZnVoL0F1NjNtc0RIdEcreVVUSDR4VTUrM0xLQVNm?=
 =?utf-8?B?VFAzVnFCWXhIVGVOSUdjSkp4UXF5d2w0RWk2akRmVFgrUXRERkN2dUtNd3Ni?=
 =?utf-8?B?YzQxVW1adFlUMkJTV1hqQVNTNmlBamtib0hMTm5tWHI3Qi9NZUVlZ0VxOU1x?=
 =?utf-8?B?d29iNWZEdFQyKzdLakUzMm1iYTE4TVhTZDBRNkpkL2UvTXc0aFZuRCtZbnp5?=
 =?utf-8?B?L3lLQ3FvcHlCZUZXQjBocER4emI2QmI1d2R5WDQ4WkNNRVRVWXVJQnYyeVpO?=
 =?utf-8?B?bGltZDNLcTJqOGNFUy9OcWhaKzNjMlpoTHFMSW1CYjU1N2ZZb0tyRXNWeFNR?=
 =?utf-8?B?Skt2eERGblZEVWpqSVptWHRFUUVaVGRUeGN6MDg3RGkrS2drcU1QZEhzOTdx?=
 =?utf-8?B?UjUwWm5rb3VaTzJkY1VOVWNwc2ZSTUJHYXRFSWowSG9ucXNhMDdGekZpd2pR?=
 =?utf-8?B?Zm5HMlZFbGFUeUtVenpZT0Jwb09qZndzTEVZcFFMTk11MjVBNFg1bWI3NjZL?=
 =?utf-8?B?SVVGL1NPWXhsdGVRYnFLT2FtOXNESmN0bXlxUVRQdmFQa1g2dmtDclh5aDVl?=
 =?utf-8?B?eGJmUFJjclg3M0FPR1piSmVTNCs0SDNLVzROMDEyS2hHdkV5NS9hZCtVWmdr?=
 =?utf-8?B?UWdQTXR6VFhacXlIU29PaFZFczJhNGtLS2c1SUJIQmNsYmFGZFFyNHU4S2tO?=
 =?utf-8?B?REx3N0k0WEJMUWVpQllWeFNvVkhRRmlPNDYxSW1GUXdVUlBTTFZRQWx4VmhS?=
 =?utf-8?B?TUVHQkdXTTR4NGhvYll1OEtmaWZiTmtWd0F3UVVlVm5rRzNmVnJBUmJLNUpX?=
 =?utf-8?B?YWlsRU4yNmJBbHQrL2dJMWdxTk1qd2pZL0lKanVNZzVjY08xZ1BvMnBLYzRB?=
 =?utf-8?B?OGpyRURQQzFiaHFXbjBoVlI4cXduWVVQanhSQjhXRjhGZncrLzNVZGF4ck9u?=
 =?utf-8?B?Rk5CMTlJeW5vbE9RMGFBckpjZ1BnMlltV2dJSDJlYStML1NNUURxTWRmT3J0?=
 =?utf-8?B?UGc5ZEQxTFBJeGUvVzJ5elM5ME14SzRKOWYvaXJVZEh5Qkx4TE42VE8rZEpq?=
 =?utf-8?B?bk9pQlR2VzR1YjFXV2l1TWpUUjF2TnREdHljZXBCVHJkYmVRb3ZrYzMvbTRt?=
 =?utf-8?B?Qk8yRWpZWk5aazRvWFRaN0xtYnZOMitxcnhlQjZnSG9LSldhY0hYT1RNMDk0?=
 =?utf-8?B?OE5MeEpMOHRxUXVpeVVuM3dzblp0akxBN3RXcWVoMHdkVU5sNTRZVG44dTh2?=
 =?utf-8?B?R1dzeUhSVkVpWDlsNGVEd1RjeW1PMGJ0cFNtZ093TVRCM3ZhWnRsUjRjNGZ3?=
 =?utf-8?B?aStHVnhrN1JxYWpoV3pHNDluNHNxY0I3bFZRNVZPQ3I1QnZtUDZqc1UzVEtW?=
 =?utf-8?Q?nbewXFF3sjU5TgW4gMBaV7Y=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D77C78B359B4D142BB9BE09F16B5829E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 0NkZWwS3PLtE7RbxxXibkDphPZZ+PILpNMoEiWGuo94p6bppYx5fOfs0K7xCFVBIbYDOb+dZoP7rbIgahz/paqE3hFZ1gyscQ5ujke6azgR4pAI9F1C+KPNV7eTpc1Z3a9zS07loMTLcIHxWTZWfxGoXdjFNlHSC4Ur9Cn0smo3rBnjquRdx/Irn+YkkLtPLR4X/bv1oJCFmxwELzOddQqTH1xsrd4JRahfAweSxiz6Pe/nOQWyofqs4SIaqFXRHx50A9/rdi+NPfmMrjFdNiENEBCb9gUbzfOca7ETG43ojWBnnJ/b8DsaJgEHrys05eFSA2Fu4eIjblpixpCVQLWbcz0bYqrLN8vcSw4CG+NRUhNslHMwVzjYgx5a8O5J5SYoXn7Ttht+kXiEe1RyRW8l7pa4sR8bU1/gVhLAS5oqUMw1AFHheJQRNX3HUStmwFHqBiKWkhTxHh6+b0D/Y8PH8jT+RplUIK3JQJtBl/h6XXs5bA5z/n95Y1P6XRI7YfwBMHD1Svio2SHPXfsMSxQ5kDXZjkPxvK5JIxyhT/5FZ79DczRvWxmgL7yd3UDyqz8ViNEcvF4DGP1bLZiyr9MV5xBlVWGgs0g+1MwygyFSBzrQWqycVoZEN+LUf7X1aKQUwdyb1H7QS4swh4CAlI4qn3RK17ubloyVB/IOhPdGvuDFNeEII1pMiNDEt052RFNIJmAA2XzBOV9j1r3n3In8OJXm7lJ82iu8yKpi7asW9vLPznVxzYRu1h6oYbQONgID3wtzbCBcSSXRFwlV+pOfpgGP9BL81bvEnIZcM/+JCPDgrXW/yd8+90p7K3yIELXJqW3rj3U8o+ZfqmG+zQvR9K6Ff53tkkbeBS5o9vBKjEwSXNLdrVg/IIuI/LbJH
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79b66968-e99c-425b-bf5a-08db5d0ea604
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2023 10:56:09.8817
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XcCQBaLwhgiBbDTK0YwFUu3e6WX3K0hooSIdBQeaBH/9/mFtsA168tkqoyvmSLJzcYbNPk+H63ZvyQUQkAIZHKP7GgrzdgJGKJJ1lQeor3Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7613
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
