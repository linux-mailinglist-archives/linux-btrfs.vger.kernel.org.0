Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF2C6B90AF
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Mar 2023 11:54:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbjCNKx7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Mar 2023 06:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbjCNKxs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Mar 2023 06:53:48 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C45F90B6D
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Mar 2023 03:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678791203; x=1710327203;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=nEDhWmDIbnspygI8UYrtaQZls2cjLI+a+J0jqdavLT+Pp/M1csiP+TvY
   GgyLixuFaeTVljuPElf7WNWzegbNNoyFP3Mp5Lrp3My2+XxjOOBTrZrul
   mPoLzyXIqIKqvtJwlrl/Jgv2OB+4LKuPWFLUAZJ3VI/01/jaEKo+5bUnX
   kkeVVePfDjCUI7gZF4CJcTI1Erk1wKWP20FSE7f5Axv4AS4qrkir4+o+V
   ohUW0u9mxLpl/atvPXTUFdjCUj/BOHid5+xDUvwhNcXaYXqQpJPwkqCdw
   8v8fbf4e4m7Slgd2VSiP/jkr11D0eqtYcUHFOjbXJ5LoapcYTpKHhZtBG
   A==;
X-IronPort-AV: E=Sophos;i="5.98,259,1673884800"; 
   d="scan'208";a="230541426"
Received: from mail-mw2nam10lp2101.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.101])
  by ob1.hgst.iphmx.com with ESMTP; 14 Mar 2023 18:53:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ONGGY7vBI2CNqmhko2tylt35OJOgI7CVIxRBOFI33GGxQNGNGf8DW0kkFxuE8urZ+w5KSVsYoSJj6rVNbD/KAZA/4Lsr03oIkiUl+R5NZv/1JE2/v7gmo2/8oFvhzQaUcXhAxSQPNGLtbS6CsPH/in+XMVWu011QQikoQxZHlqm2qrWcbBpltkhuFILZd7l0EzkrwEbNtBje12MfLbQObzhbgcsv5YNpy0B3dOFC2fQrCRVBiU4RRMNPsweoyI8+XE+6t4GHnj1RkP2Tt52AXjvwADNwXOZeEhIiYOcg0lapCQ7p5xiMEw4Yqwr1n/YaHUnBbZ01MDZ9htquGMtjmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=IzdG8ABuHUjr53EHoYL5PqQC1of67aGTdlPDraGZubSte4FiUIoFXSyPnLx+vhePHHda+rjnmT6rYtTeRCQ46+sh3oFJ4dtc0lw01x/s0b8z46HYs/9Tdtb3a91McHgeiVk+jdr0KKsi7q+FlQUSZaWGB5ftJHDtxiZKAlfrjoAtqcHLxiiz1NTLBOIUmWVsKPYSNm2IeP0mxBuG9f/NMtqoYxTaenvoQh9I7TDlzDqpUnLTES/Guner646YreRRry+XHkDf0pqUmv2icrlN656v6NbSlmqrRv2nvNtykvFjWrGnYj0kdR8KWtzo/llf9p5+6ps+CjKuFDpvl2QWrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=LVFi7x6KK8hrdrSzmoYiZZ1pp9nGcy9TwPE1LQD0ZM0iF+gH1yVRtqxAe8IdVqXJjxEnN2g3A6UwJPmAIuBcjQNx1cL8JyDWMJNEGkqLgM77fcY8uhjhPFhBluyyiPnov3d59IxaT6K51Yn+rBXXveoBIJ621TegCtdfxNQJROk=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM5PR0401MB3637.namprd04.prod.outlook.com (2603:10b6:4:7a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Tue, 14 Mar
 2023 10:53:20 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%8]) with mapi id 15.20.6178.026; Tue, 14 Mar 2023
 10:53:20 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 14/21] btrfs: simplify the extent_buffer write end_io
 handler
Thread-Topic: [PATCH 14/21] btrfs: simplify the extent_buffer write end_io
 handler
Thread-Index: AQHZVjy3m7WSqsemSkq7A/frS8GO+K76GeaA
Date:   Tue, 14 Mar 2023 10:53:19 +0000
Message-ID: <a4f9f959-561f-0945-1496-d8893bdc7582@wdc.com>
References: <20230314061655.245340-1-hch@lst.de>
 <20230314061655.245340-15-hch@lst.de>
In-Reply-To: <20230314061655.245340-15-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM5PR0401MB3637:EE_
x-ms-office365-filtering-correlation-id: 5bcb3bc0-7631-4754-6f87-08db247a52f3
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Wk77STyuNdItG7EDoPb4FD0ultJ68YAMtgA7rMwUqoFhfNObQMIV5yCgMQkE8EvIDeVFY8RgiE3S1YfVvaNEWPRkILIe7ytxhsgJeoxaCMipHrWB4N8DyBhQU5Wk+7aFfUp6Zk/WLj40QL/K6rALw13WwXJQpYVvZSx8sliSepMXoFJyMDKOit45KhzJmoinT/nm86mKrlzpuQqmNCeoyZZdW5Vpf0jCNEAzfsZzaG01pgT6r6eL1vANBo7GfC2u2Rim3ORDQJeMNMIadNxqO7tTb2m9/LOGpiTKkFqAVajHlil+Ibz/0sB4m3BlZNEdaVSLOwBX4/Yeakrb2a1w5Ma4G79ILcXGSllkzdMTz8c+sRFUSSj8XUIUOPue0s/abvt1yU6HH87iU85Nx0iMcrmqhXDhwWT0FR14ST83R8IFBz/FWcZsNkgbKvjmTRM4QAYDNkeKSNfByy0pkjCmI3o5H556PkCE/KVsmywzEQOjQHNbYBvBne7cUwo7tuXLXqUA/Rp/0eJHMnL9vu7nGN9IZdEtRldoIDSgU3+jesO2IIYONW2Cs9ydcWAwAcVBDq707hyB+qxebzBikdhIlV3/KhmZqppW21LdRYKoBEd4c/J3zLZXnx8iihWzI7uF/pc1Q1bmJAcve94P8I/lF3ZE9UrKo1fUQ87C3/8X4BJHoZTil/JrZfSoH3ybA3x8Mk6+Ag+Sec+QpKsOSe1Zfb8FOyZ8qS0zVJnmt1cY0gL9ODEQRl2glNpo2WqcyhW2KijXokV2gr4ULgyxWpjmEA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(346002)(396003)(366004)(136003)(451199018)(2906002)(31686004)(122000001)(19618925003)(82960400001)(558084003)(36756003)(5660300002)(66476007)(66946007)(66556008)(86362001)(8936002)(8676002)(66446008)(4326008)(64756008)(38100700002)(41300700001)(91956017)(38070700005)(31696002)(316002)(110136005)(478600001)(76116006)(186003)(2616005)(4270600006)(6486002)(6506007)(6512007)(71200400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OXQ4cHliNGVJVWZ5elBBa0VCSGw1QU1TYWMrMFdndmNaVGdZVXdwQjZnSmdM?=
 =?utf-8?B?YUhpY3hhUUhwSVJld05md3FlcEJTKzIrOVdZQzM5d200QzlsVVFnVHArYXpr?=
 =?utf-8?B?cVcwS2lpOWdVRm01Tm5xRVExUTNRQ2hKLzBnelcvclp1c3RHZjIwQ2sva3hz?=
 =?utf-8?B?WVhIM3hUTU9WM2tRYXl3cmU2bHliSU05UEZMS1hybkRIWitFZ0k0ekh0NEY0?=
 =?utf-8?B?Q25nemQ5QXNiRkRVbTk3UFUwSTAvMnFaSXdxUjd5bEM5RytDVEMrQlZsQmsy?=
 =?utf-8?B?bTQxdWg3TmlxU0xkR0ZaRkNiME1oR3drckpRaDV4Mlk3K1hQV0lseXVoNUcv?=
 =?utf-8?B?ODJlNDUvc3o1ZE82c25CTzg2Ym9kbHFTOWMxSlFzRE50cFNJbzFsVVkreXRP?=
 =?utf-8?B?SGhXeWtUYWs3WldUMytheG9jaDkxZjQ5M21OaEt3ZUdmS1JKcTZOUWhUQmRw?=
 =?utf-8?B?TjYxbk1JbE5veFJJS1RvZU5mQ3dTUHp1SHFNOTFwa3dPNVFTdCswMzJ1ODdh?=
 =?utf-8?B?RE9aL1hocTI0bkxqNXpYSDgxNDd5V1BSYnk0aDNvUTJxRnJQdllodi9yODhI?=
 =?utf-8?B?RkRSSzYwdDVaZ2grWHlrVmZzZzYrYnJ0SldkcCtMZS9HZlFLQmRJWmovcGJ6?=
 =?utf-8?B?L0VKWG9UTFlDaVJ3TU9Sd0tkRTZ3am1UWWMwTm1FT1dtS3N4dkh6aW4wSENZ?=
 =?utf-8?B?eCtPRDRRaERsTmZqRjVQZWlxbnQxYm8vcUExeWs0UGV0bzRKL1dkanZVWGJ0?=
 =?utf-8?B?cDJkditzMUdlYmxVd0JLcXAvYXNJcElsTmxiOUxPNSs4YkFIV2lQbDgzNk5S?=
 =?utf-8?B?K0hoOEdpV2NtakxKWmxNNFMrdFVDWEhWVWswcXE0V1FBeEc1N2ZQMmt3UGVF?=
 =?utf-8?B?K05mcVFXRm5HNHlGc0RUQ25TWERBeERGTlBCTEJzQm01NEFEdW15UWdWWnRB?=
 =?utf-8?B?L05hK0FlTm90Tmx1TzBaRWsxTEdMOEJRZTM3c01QUkc3T2hHT0xXeEd4bmlQ?=
 =?utf-8?B?Q2RQSXJvNEZjT3BzSC83dkNWSjRNZGFaRDVyeUp2akhjYnI4azVjbG90WVpG?=
 =?utf-8?B?M0o2bHc4UE5kVjJhR1dKVk9NK0g4TmUvUjVYbU1CbDVnRGtpOVlJQ1lDeFJY?=
 =?utf-8?B?dnFTOXNUQndlK1JiOHF2bERHbjVVVlpTaGNyYWRYR3NmSlgwd2Q3QkZTdk45?=
 =?utf-8?B?VGhRQjJ0blFKcTQvVXhsVXRtemFpV1M2WWY4T0V4azBVczN3MHdTdVNLT1Rr?=
 =?utf-8?B?VWVtY0cvNG9UNlJFb3BKdnA2eXcyMXUyeVBMZU9Zay9jbDgzMEUydGI2T3d2?=
 =?utf-8?B?N1krOTN4ZUZrdW11b3l1QnVmTzNtY3BINVR4ajJXNmRaWVQ0NXBkVGJoTkFl?=
 =?utf-8?B?V1M2VGVuYmNzRDJ6clNPUk95TWJsYTdqNktjUlR2bm0vQ0FkNDdpUlEvdFd3?=
 =?utf-8?B?RGtpeGdEWjZsbHlsRUtUeTZUcXVjaHZ4T0ZFVWFtRW05KzloNmtZZVQ0TjMz?=
 =?utf-8?B?bmxRbG1MVkJSMmtNMjdjMjcvRlozbHhlZEx5Mzc2Sy92Z3M0L2lWcktKZjdr?=
 =?utf-8?B?YnRDSEFFMHJtejlKRk1KZUJsREh2SFZvYWFzUHkzTW9NUWR2eVN3RDFOMHJm?=
 =?utf-8?B?NHRvRmh1RVBmS0dKK0pZVkZNY2ptU012azJXNU9sYWQ2ZVVOMGEzNlNlUWs5?=
 =?utf-8?B?NlVWeXAxeUNodll1ai84V0wzNTJmWWQ1dFYwMDUwcG5ZaXI5SEw5VHhCQXg1?=
 =?utf-8?B?QUl2ekhYaXdubEhuYloyU3l4clBHT2NlM2U1aU1wMEU2aXlVYkpNMUVzQjlD?=
 =?utf-8?B?VXhQTVhCYzVSbkt6Y3hia1hIR1BjTlJ4ckNvTTN3SFQxU2M3WERGd3BNMnA0?=
 =?utf-8?B?ZTB4SEtGZ25jNm1BYi9hZzVCY0NCU2lzYjREWWFVcWthWmtHNm1EQmJtQXB1?=
 =?utf-8?B?enpKZmlhOVhMYzdUQ2JxN2ZYcmZ5ZkdOdGtCaEFBdDlnbDJaU1E5OG1xK2dQ?=
 =?utf-8?B?OFJjRW80R3NPVlI0Tlh3eVNkVmR6bHkyeHhIeTVzbGZIRTdPQmVQb05kU3Rs?=
 =?utf-8?B?VlJlWXhkYjZXV2xxZGdVQ21TeDI4bGR0NHcvcEppZnFxUkgvZTVBb2orbElK?=
 =?utf-8?B?TndvVDZrOEQveDlmYkVEc245UDlZVkRNcGkycHRpUE1LYnZEWk5ZMERZRVBh?=
 =?utf-8?B?YmdNRE1Hc2J4L2E5L1BjNWxCbTduc1BuT3Q0czlqT1RkVDhubHpLTVlXbERN?=
 =?utf-8?B?Zy9BU3lJVTFseGE2MzMzU25GeEFRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1D0139C3CDC7404CB6A40335FBAE8B7C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: NrKhu27q4wP8+YrfVlPmtcDhriRW3oHm4gk0e2D7984habamw7gKSuiV5aHVTt9SDLFJuOfjN9WGBNlQW0Lk1tjDAzqUe5I8+awssyzjG3AIu7zoOFBv10ouxDiblRSM2dhKqL1Q10GGhFQt6pHZJmnsY3Vld9QDIC0eM/B5wWpvo3PJX+87qRHc+72RgpoHZ0K+eDXeiJ18Ap4IObSFzOqDbs3N4brpuBv6McsDF5+Gh0gZmsnFAPRstE4IWc4+X/HtYcOZpGInuHwHQqI6kRCORVUddK/41dvMGWLZxoobZgTzKHFu3TLmqYRCSjCuMqLecwVIkDqW6rNHN8UvyBVejo2AjYBhEwajPEXwJHy1HMb8dNabNl5pRWbFR5CuPuLg0IRoXK3RyL8ne5qOrjSUpClC6Aa1UFzIhuawDhmlnNDWQ/+0taLfEJpyXM0E+MbKUdiKLaQNxFEoN1xPk2QaPWH/Tmd51M817qXqsYHqBgOB7yj3h5q0GKO7n8bTtL+nHn1gpDjANHnZuTtiAV3ipxlE/gxqGCC2QR8FbF/PgtL3aHGJ3TU7xbt4tIpy8NxY84hqzdk1i01ZvB2y7Z0X36wYUfewHgrcNGpCcXm2CfaAeHotmrb65mcHnuiMenMU3OCFi+oTPL9fm5o3pxuTSET8JpHg1/dcLSMoRyYLPOGUNEOyV+3SZCAF7zqKkxRZ0kNBNTxzhaNB2PMu4ZoP3sc76poZUfrCP6u3A/x7NrgAN5NpC8EjiuGobwFqx5G1FTmUhMtoJssAuInv8mlBK7COXZ798vyfvcfWNygkzFd80iHivecgoefT9HD6L41jC9LLChsNKCEH8V4dW0XvQ19jQdO6AtlZayH39NMdUdThc6aix7XvjdoFBsdv
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bcb3bc0-7631-4754-6f87-08db247a52f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2023 10:53:19.8884
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7aYucue8QfatVHS3WmEeXFOuVtcwbq/qwdbR8v1gHQZmdc2WUt5Tr1kW3AXqLNxkvv6frMu/AYpzCoto/uIVIRCWLbFhrpX/c3IXSiet/1Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0401MB3637
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
