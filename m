Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34BF06B2517
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Mar 2023 14:17:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbjCINRu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Mar 2023 08:17:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjCINRt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Mar 2023 08:17:49 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E389E41F9
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Mar 2023 05:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678367863; x=1709903863;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=++FmUGmAIAfXgEmL0eWdFYrBn7Q4pmI2LORJBZo8py0=;
  b=oa84w5mL/ETB1is+sjf+kHXJGk220Y1aC41JzLNpPGCR6FmmZ9B7k9DS
   r+fdNAFmYIFwB/DceY2af3Z7FiKzldcZusyqHmm9iKQofvyO3ikkamXbe
   Wu29s2M/XOqJmBuiWgPlxi85XKRw+2CgtU5YoTsW6lnLo/4BqMT6VqeMJ
   hWWlKh3+Di1HMf3V/djTPqEnMZfuslsMb4dFiWUJwbcWIT1IKWot/3Ka4
   ISMoWI7NthD/DWyX3bhYsHr68xQ0OVgE8KvBPzomnHajUyAIu08RHnt76
   LWvpHFhEWzERUEn49sqQ6tBhN4HxPvHtoIe9bQ4Q+6uZL9+ZcN/JPr1Cf
   A==;
X-IronPort-AV: E=Sophos;i="5.98,246,1673884800"; 
   d="scan'208";a="223517491"
Received: from mail-mw2nam12lp2040.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.40])
  by ob1.hgst.iphmx.com with ESMTP; 09 Mar 2023 21:17:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nF1MxCruAicpMzQrNXcuHgd/PVV9EzcT4fVDzpPt3ayWx0ko7UV9NcfkOfTJdvGXF03QX2IRyt3Hr/FUr7VIyNiH0hcoUNrVnhujtnxjS8x3esejY9KGMCt3WrQ7mv9RJtdL5OcSmI6SMN7D9iJaIPrEKWAHInyKZwsEg5YAbsCuu6osz1O8XRVwiBlQXBuaOn57QqRyAoAVufYtppVdToflVJhYqrJbFH/PhwUm19X2kFECCnkR7k+VVKnwSkk0nsUjbnDkrd+22k555tSgIGcVdSNtrfdjAwTizS3cqhVlJKvjDucp2sE35kJAECerBnHE3L1FZtA1dDJ7IZfDlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=++FmUGmAIAfXgEmL0eWdFYrBn7Q4pmI2LORJBZo8py0=;
 b=MHktgKeNtlD/D67W2lDmC1IwXZ0ov4u/IC6v5vpaPZmHfN/bWgqNjF1LS6h20SWFbjpInxQ3vX/rQq35Pm2xCp61+fcMbkxlS1H+zTVWG74MiSDUvhAzljme+CcHPZhr0kD2vXf90N5cVmyMoeVNzoGBhLuz6dg1Ni+0fUB68NmoztDpydgBEg1mpTVV+uCoWUal/iE3oZNFSY96ZigNfCctXCqArYz5W8pU0nlQ8dFnJKxUydJVwS3oneoMsKW7G9sNyDBY686w1BryAjjbaYLZeAqOT/ARa2kUmhneUxOR4HDZbASTl158j1CXsP5JtqYEGhSYUvyopdaoiP9gfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=++FmUGmAIAfXgEmL0eWdFYrBn7Q4pmI2LORJBZo8py0=;
 b=BOV+Tg7/+b5rkw2kEwRGTL/SYsl58UIDeh/xL/UY7igZtH7RSmYf5enOMEXMVRmHJo+g6E9CCnIPXikxg3k3CS6hy7rfuzslV34vYetK/pe5+m8u6VLZwLt2PdaemFBMKAcI3RgGxlhhPdSoHQXuOIlO1Xwl3kbJFNQUKgaUDmI=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BY5PR04MB7010.namprd04.prod.outlook.com (2603:10b6:a03:22f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.16; Thu, 9 Mar
 2023 13:17:40 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%6]) with mapi id 15.20.6178.019; Thu, 9 Mar 2023
 13:17:40 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 09/20] btrfs: return bool from lock_extent_buffer_for_io
Thread-Topic: [PATCH 09/20] btrfs: return bool from lock_extent_buffer_for_io
Thread-Index: AQHZUmaUqU0W+9tcVk6g9+80zTra4q7ybj6A
Date:   Thu, 9 Mar 2023 13:17:39 +0000
Message-ID: <33780c1c-694b-9383-24e3-d2e0ad87cbf8@wdc.com>
References: <20230309090526.332550-1-hch@lst.de>
 <20230309090526.332550-10-hch@lst.de>
In-Reply-To: <20230309090526.332550-10-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BY5PR04MB7010:EE_
x-ms-office365-filtering-correlation-id: c461488f-f37a-4eab-0394-08db20a0a8a2
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fZpuMk9vUoOtZmKD6tUfyXHlVm68atJHfvkqLjH69nLmcUHFbOu1dgLm2h41PZbr/ujtkfkOEON/8Tt9nfmGV0oV6zpO/ua2zPfN329g/fjLLFHLPNbQVKSVH8282cgOTPCE5YqrDjPux4/SHYNuXEIaq9KT801C625m6lx+ypnptrCZhe6gF9UKthrHSuN5oaAJEiyyvdnNK8/wr+JDdli2/zTVDH/eNwP02QG8k8gIBOPyAkgOWgV4c26xjcvNXk7fHC+bSfTJ66FTPJiBnMsMLAxgJV56pHkg2/q0RDx5O4s/E0jmmmFwmem1VzvFzJjQpttMRTE7X4pMHhfAiMKqpDwW6cmSA1/43Ioc1SoIdEss+dHGXBg8wS8Dd6vRz/oZHT4Tpxp44iP9y8dFbzjJzW36PnRg8rYBCyUN08XNJYy0dEV/bfxCHD8hYc08qVBL2ndSJycNxuFFVmep3sa45qoKnxllY0rpoCGP96gAH5YWM6cd9CizkMB92Us2Qs5yREbjgcStI1e4s4uPE673IE37JPPvYHJ0mAUA+bd1DseT99EpuuE4k1gg0DPf2cKgGDHhiqOCuIVcfeRvthSTwp0KKQKLFK8dH8/azltl0z9ckF4zSbtyDVcMyCJWNSLm1U7MrSJl4D14tAzwVf2sm1Mm587iQ0pw+zcRziXXDfuHHqMqGoSL/lKxsAyafrImmBHezyaF53W3AjP8R7/Y28+VrO1ESlKg9EVsPxZyjEUtwNQmBeAbF9R0q9u5GWfPL0DSoAWuSC4yPko9+w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(366004)(346002)(396003)(376002)(39860400002)(451199018)(316002)(2616005)(110136005)(31686004)(122000001)(6506007)(36756003)(53546011)(26005)(6512007)(82960400001)(31696002)(8676002)(66946007)(2906002)(64756008)(38100700002)(66476007)(66446008)(76116006)(4326008)(91956017)(66556008)(86362001)(41300700001)(478600001)(8936002)(71200400001)(186003)(38070700005)(83380400001)(4744005)(5660300002)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V09rd05obVozRGJVbXBMTCt2akpnQXpMaHlHUTVVdE52Y1ZoRDhXcXliaG83?=
 =?utf-8?B?b0V4UHlNS2RSR3FvNDZiZGVmWHpDaFRaemRHVlQ5WHZyWlAweFlXYUd3enk4?=
 =?utf-8?B?ak9GUWF2YS9LVVpab2EwVjVpLzZCWmNxQlp0UGIzMjhhZkdqT2ZMdWJ4ZkY0?=
 =?utf-8?B?RE1hTCtzVXpra29ocHdGTWladDg1Zko0WGJRRncxeEc0Q1FJUml0UjlYVFNQ?=
 =?utf-8?B?STZDSVZDcUR3bTVISlJ2a2JXUXAwSVRxMldhYlV2cTVaR241Y2VidjEvRU4w?=
 =?utf-8?B?NFdRWnBGRTVUM0dqTEVOM3g1SmFaSFhLTENrSloyL3U1OHlrakNVYTMzT1ZR?=
 =?utf-8?B?VkdkQm90R1ErQ0ZGNXJuMDlsUFhjVGVSQnBFMWxBZXJKK1ZJSWREa29HbzhC?=
 =?utf-8?B?ZlM5UGVVMllPbVVhZVRtZXY0YXFBUFd3NWN3dVJsbXlQd01DTmFyMTlmMjU2?=
 =?utf-8?B?T3NEWUpCZlV3ZnF1dG5UcG43UjFpeW5mSmp2MWtOelhyUFZQS3ZUSllJSU1E?=
 =?utf-8?B?TFNkbEN1SDlKSHl6UC9wYXE2cWxYRGVSbTJMa084ajZ1OHFzS1ZtWkxpeUN2?=
 =?utf-8?B?N1F6SUh3SUI5QTZabWlDSE1JRU9lMkpQQS9qeUtDQUl2UUdCb1UxMnBnbnEw?=
 =?utf-8?B?VVg0UkQ5WDFxZ3FQUnI4RHRja0VYRjM5K0ZybEg2eTI4R3ZqSzlNYjhsUFNy?=
 =?utf-8?B?a1JVYjVYeis4T3FiaVdqQ2ZPLzZHNnFKbU40YjlNWXUyVGkxMkV0ZU0ybVcy?=
 =?utf-8?B?RXhCQ21SMFlxL09aQjZmaUc5OFhoMlBDSjF0Umg5TmY5ZU9OQ0RBaGcxWWdl?=
 =?utf-8?B?VGFnYlpENkQ4dEVhUmI5cjRuOCt3eFFMaUVMekJRT1pxZjVKWEtsTVJnTWlD?=
 =?utf-8?B?K3dsVGtFL1NpVFJCeEtJcnZ6dUFNT3I0L0dvUElBZFNrcE9nMy9LWHB0UGsx?=
 =?utf-8?B?dnRXOUZZd1VFVXd4RDdZUUw2WkxKaTVwZG5CcFd6aC9XVmJFb1JVZUlSNGFJ?=
 =?utf-8?B?dnErSHZQbDAvVjVBSmZiYUtwOW4yZ1hmYThnLzFnT2dBQlRKZjdsN2ZzM29T?=
 =?utf-8?B?T3dVSVdCbWdIOUFZTUVDOG42VHFYeURQbjZybVZ6RHdjWHZTcnRTV2VsZVdm?=
 =?utf-8?B?VmhNREVuWXdrOUFIWUs5cnViM3JMOW16a2t3WTllcG5HVVZTWTRqUm1TTDVO?=
 =?utf-8?B?WGlMcE9FRHJ0bjdzcHpaZjJaekZoV1F6d3gvRmhUVldsMDZPMnI5SXN0VGdq?=
 =?utf-8?B?Qml0NVAzWHpvdW5tQmhlOVBBcVBDaTI3TTVUb00zTVhINkF6YTdUZk1KZlh4?=
 =?utf-8?B?WDdtc2paL1NraE44a1JoVGdKQ1BueER2MWlhZGorTmpDVEExd3hhbStPTkhx?=
 =?utf-8?B?Z3ZEWXpTK3hnZjYybEpxNHZsTWZmTW5qZm5SMnNNTW1zS2FzbzdsTDV1Vkd1?=
 =?utf-8?B?MGRoUWlwNm9PeElSNzl3Ym9wakNjKzlLclpNbDBvSVkzVVJPODloY3lPK2VI?=
 =?utf-8?B?b3l6RXJzVTBsK2lvbS93eEp5elRCcytkNFBRZEFlUG5jSFhxdmg1akVOL0J1?=
 =?utf-8?B?VUQ4RU9Hc05lK1kvNE9lZ01hTDhNOTdIbUxtY3EzdzBJLzVjdW8rTWpyQU11?=
 =?utf-8?B?bCtiS093dEszRHlOQVdyODBLYU8rUGxQNnIybEZWdzM2VWwrOGEwd1VQcUZJ?=
 =?utf-8?B?dUhpZkZENXJoYy9XeXRKUmdabTliTTRTZmVFWWJWQkdlVnlrM3NaK2tCdGFP?=
 =?utf-8?B?d2p1VXVUUlhlRmdQNXBiVlprSXFvTWJLMmsvY1pJQkhnakpRM1AxOG1OKzlU?=
 =?utf-8?B?dFkzU0tkR0RmRlRKM2VQZHNsTVdPM3FYcjJrSzBWOUUxbWFWeEpmNjhWNUU1?=
 =?utf-8?B?UDN6Qkh3RU51eERnYjRtN3lPUXRYUjlaNlBudnM1UVdSNkExU054dk9adnRq?=
 =?utf-8?B?ZVgrcTZZRHdzaWY1VnZMRWdrdTd1UDlXLzY2RkI1MXJKS0tONXdTVUdBais4?=
 =?utf-8?B?WFVNalkvOVpDMzg2a3cxYmZEMDZ5eVFibzRKWk93SXJsOWpuM3N4cm5oRGR3?=
 =?utf-8?B?U0ZUREpvNGxyOU9LenhNYldlaXVRV09sa3dhTEZ0NzJqd1VCWmNtZDRkOWZP?=
 =?utf-8?B?RXBiN1QyTzg2MUV1ZU42VmE4cFBTWGd3V0FhT29OQTNQQnJURTRJWGdMQTJT?=
 =?utf-8?Q?9FQ3hzfh3r4In2cIpPgKxUE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E43A99BE2A00994A93D53D5E65639321@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: EypOPqnuX90XnkshTQoO9Qrc0VuQ2aLlkQ7jUjpvP4FUzZogJp0kBtR62P9h/wPVrgDatH79GRwxrG5lSP14jcOYqJBkH29HtHdlR4cCMirvEWMjhqNuhbrh5758NFylB8uPYmFUMhaumG2+0/hcbm7AHirLO9/D4G1Zwb2dtdxITB6r0LlEURiAw24khyevnWAxlkqDBO+qEZ3gVXpBgWC2koAFWfWbsyG/StnOW84Qyazo4Z51rH+WvCUz0dqf51BtnNrLJIgy6KCQmp9i6BqsfhEkOaEpT6zVjt2zLVPh81PjwJogF3+3Oumrjnp4a4bCGyJWOyYDEcHu8Jwx+hL1XyLwgjv8mmM8fQUZ1TgdQR+IQ6WT8rVp8kmNcBrV9q8MuCgVaQAaqF4A9wAn+YkfTRAVqpoHJ5rMjk9gVrT015RLG3qi1lADFpCtwYEfkH2r4HBYm8+DZDfwIVsXICAiqHhf6qP9jWh0jT0VNYg8qGtwRgiYKd6bVuwGl5pQ0Z9X/K8OWeCKhW16I3sm2dJ82BXJj2CZKooKtenfvbkW4w06E0320s8VvBaizB1ZXRTAnyadB21U2vWof2r/c9vVwriy9T7WPyPr2UmcFipS7WJDDQal0lqR6yFww+Ti4SZGtkxz38flQ6FhbvvwvWyByQE4CyTBUdbiOCiOkwlJXfyemU5ayFSrIoe1yyGeIcWOD8ZwMrMZcLgjreHe1Gkdv4Qi32uAUwZlaPYyeBE+wmgHDiKpOXKeP7goO/WuWQE64HL//dmm4koNVSoJu6Yv1jUAqkKLYvybtd5SzG8CSbTXxyZebBBam3ryQPEA/+HGQUBQJ1c6RdaCr832oNy5xCMyKRXsk5P1UQMaAK/PrbAK4MB7Nm4f55xUphc0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c461488f-f37a-4eab-0394-08db20a0a8a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2023 13:17:39.8478
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4l/+b+ZDWWBdkNojhE3r1etYYEkYVUV3hdgxEmW4CWveujBzS5PJzknCCSLzQypkGJIxxJ7P4a9PLmxKrvKFCV3e3PTMfTFvsPPz0Tsw6w8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB7010
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMDkuMDMuMjMgMTA6MDcsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiBsb2NrX2V4dGVu
dF9idWZmZXJfZm9yX2lvIG5ldmVyIHJldHVybnMgYSBuZWdhdGl2ZSBlcnJvciB2YWx1ZSwgc28g
c3dpdGNoDQo+IHRoZSByZXR1cm4gdmFsdWUgdG8gYSBzaW1wbGUgYm9vbC4gIEFsc28gcmVtb3Zl
IHRoZSBub2lubGluZV9mb3Jfc3RhY2sNCj4gYW5ub3RhdGlvbiBnaXZlbiB0aGF0IG5vdGhpbmcg
aW4gbG9ja19leHRlbnRfYnVmZmVyX2Zvcl9pbyBvciBpdHMgY2FsbGVycw0KPiBpcyBwYXJ0aWN1
bGFybHkgc3RhY2sgaHVuZ3J5Lg0KIA0KSSBfdGhpbmtfIHRoZSBub2lubGluZV9mb3Jfc3RhY2sg
YW5ub3RhdGlvbiBpcyB0byBoYXZlIA0KbG9ja19leHRlbnRfYnVmZmVyX2Zvcl9pbygpIGluIGEg
c3RhY2t0cmFjZS4NCg0KDQpPdGhlcndpc2UsDQpSZXZpZXdlZC1ieTogSm9oYW5uZXMgVGh1bXNo
aXJuIDxqb2hhbm5lcy50aHVtc2hpcm5Ad2RjLmNvbT4NCg==
