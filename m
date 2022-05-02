Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1BC951744C
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 May 2022 18:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242744AbiEBQfw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 May 2022 12:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241337AbiEBQfv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 May 2022 12:35:51 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED50B840
        for <linux-btrfs@vger.kernel.org>; Mon,  2 May 2022 09:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1651509140; x=1683045140;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=vn3gaOXtmMY3498RyrAOx4FOKvu7mEqpzV6pVa3sZIw=;
  b=MNxKicTEHOai1rMmPG8OpZNk6wnZBY8qaF74OzYpkVDdNUlNzZt/kR8Y
   viVqQAnMS+pg9o0cLbXtDg3R7XF06huHY5l6io3nctLXkeUZ1xY98lGE1
   uJNt1D9WwQCHsPaviaJGhdehlRui3oT6TCWvpZzXBgDEePABwNM1ZPp2s
   gbuhGEIuCBCgfp3I1n3jQYalfEYHMQ7D894ytffi6yRqzFlX6afOP95Z5
   c97ZenJ+oNxAKXbnFrubjPOwkm5kAZb4LQkBEekj7OsY3CvlY4xR/2zpE
   /b2mXC3mwu/tUb8AHghP4Qaxl6lXZAMph9ppDEpenVqlln83YuVj21S5w
   A==;
X-IronPort-AV: E=Sophos;i="5.91,192,1647273600"; 
   d="scan'208";a="311322982"
Received: from mail-dm6nam10lp2101.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.101])
  by ob1.hgst.iphmx.com with ESMTP; 03 May 2022 00:31:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fYMfnf011kidwrTTtsTdL7Ps//VJf2VHoKkhhaLzfdBJw2qpX+86loFLcKH9nULdU9lvypMcQLObhEHPx0y1qMFGek6Jc/0f8dh1x20qcyKDW6UxOpRPh67AlGNb7ZAqQgGOr93qz+dENIJJe3WkfbGglEFLgAUCftw9AmcMcSnxcUifEtiikK6yKYSnPrG+32gWejDHdY7el9Bpv3VPYV+bWvfx2AiuzcFdlv8wVXadlIlJ28Uw/fEHUVa7jCjNtioMSrix7bLoWuCX2PFtgxDqLfDIA/oHZVTIcc4zD6qsdJ95xJ84dTTmt8YkNZm3YGdlYdyohTjn5EKTUXtgEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ahTwB5P4J8OX8P9n1p9JXlSdKc2kisApmodDQ6oXB2M=;
 b=S7MWtXT+7BJqKpNLUNZzZqJa0TzKWNZ5a5zJco+nx7yriANJ6XDHwLAyRFdjc9D5G7yzZQeS785dyxNZx9pKuAL3SN7MbXV5pxRH5CIlAYBzwJlGj3IENPe4bubSXdIGvmlbjQA76naUuwjgG0cURtDqw/Riql7OX2BqxiSNB1+YqoR2HRyKPN0Fl9PbyygF7cYTfQlfGp71La/hIuIfnTrgaznxXZj+2TGMESVwr4Dvz7JaJdIQZ2YCO3pD5h7GSBwphnl7PkeKVx04VxWm18e0csvtdPWH1PryjDFRaexpuFFt13HcHzAI5QTPGhZe2YRzDnBzC9GkqC0GKShqkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ahTwB5P4J8OX8P9n1p9JXlSdKc2kisApmodDQ6oXB2M=;
 b=iyn/09TDK+Epf7rtsrIXOMVkX8FqqjQCk5KaktuHlLaeFKaI6N1RCldgRmPowvM8bhnRdeMLYoEUIioGg4PLXQiNFX14DTomErkaMkP5MiFz2KEPbnN65DaTmSnXMu1+lIXXBgtzSORqV4Aps9SmJ09INfqDwuhaUSiMQwecetE=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN2PR04MB6479.namprd04.prod.outlook.com (2603:10b6:208:1a2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.12; Mon, 2 May
 2022 16:31:28 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12%3]) with mapi id 15.20.5206.024; Mon, 2 May 2022
 16:31:28 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>,
        David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 7/9] btrfs: rename io_failure_record::bio_flags to
 compress_type
Thread-Topic: [PATCH 7/9] btrfs: rename io_failure_record::bio_flags to
 compress_type
Thread-Index: AQHYW/dzkKEzE+jMckCfgwZPJ+TiWw==
Date:   Mon, 2 May 2022 16:31:28 +0000
Message-ID: <PH0PR04MB7416929D574A11EEF58AC3759BC19@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1651255990.git.dsterba@suse.com>
 <54b867c85b5891611c1a8f5a412abb06bbe5db61.1651255990.git.dsterba@suse.com>
 <PH0PR04MB74162830148A045DDBF6FB199BFE9@PH0PR04MB7416.namprd04.prod.outlook.com>
 <20220502151659.GK18596@twin.jikos.cz> <20220502162625.GL18596@twin.jikos.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3f00c3c8-b933-42c3-dce1-08da2c593547
x-ms-traffictypediagnostic: MN2PR04MB6479:EE_
x-microsoft-antispam-prvs: <MN2PR04MB64790CC3BC148731251196BE9BC19@MN2PR04MB6479.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x4Tm4N2wD6JpwWsOsiDpukmxiLxWoIU2pNWVBmh4fhZuGkVZM9RkjST+3AxkdQvQAvGvgxZVm7sQIre13QNt0IF+hX3OYb2vBsRHiePObrSuATmCpRxcK3tQBUku8K/zZdzaNA8w8horQHqWNtXMEtcg2vdkhifEPM3841jel3lgnTiDP7ereV/+wV6Ac3tANUysTIf2rvy3QtzRmN+Q4SXBi1WZrtJDEC6AZY4lKgj7ai9ohaL8eXk+PJnsdph3zI4pG3UjrOZVAKEtb3RK8xWWyc59hfLLwroKHhIajfUNw1mMZTlB+awVqnCKDMCzbgNZC8QbFELZVMJ2fVFxcvMKHL7MYRVSlummVtC5ebsGV35zlZIpGs10Y/zEqN8yglXLZyh6u4TXDbl6JaFUdzMMzSx7cXYE2cnvJEa8jzAxIZ6Hj2oMdtpy8nuHmgs2a1zyQvd3tdZI4HDrbeZPDYqnqDed2Almmh//q+YNfCgdQuyzqI52lLiNOiFIgHQCpMCefipQfh7U71bLFmYl6Qn+upnQyjrmAXwrXarcvE4/saqbG4ch4jF9fHscBLeu29oi2SDnliKIUVFhD0/H7MRJGz9YMvW8D42ZwOwaJ7IXuHWB5/NZjdlqtx6yUNLPHTDNTnhitmfKqFNEcwkiIwuRr0f91qxP9qy4zpwQTsI9ptAJ6eAgV2fmiJIXUce7ySQk9B8iiVmV+b9+hY3OPg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4744005)(33656002)(8676002)(55016003)(64756008)(71200400001)(2906002)(86362001)(316002)(110136005)(53546011)(66446008)(66476007)(52536014)(76116006)(66946007)(66556008)(5660300002)(8936002)(508600001)(7696005)(83380400001)(6506007)(26005)(186003)(9686003)(122000001)(38100700002)(82960400001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eY74C07e3zwvStnxA20esmF7IWMpOF4zmS6n9WoKWAqCHSy/EdF0tV3R0K09?=
 =?us-ascii?Q?bRFgWzuIM8/WcfUgNAosus/r2iNGTzoLyJAkqtgsEjzrgZwYVsOoO8Fn0DlX?=
 =?us-ascii?Q?Cpg3h06mT9cIGRZJL6Q89A9dYWhCnScdJikKCv9rvamTR4aUL75zgPTYfGuJ?=
 =?us-ascii?Q?SuFJ73HkFxos08PY7HjK3tYoy1D1bVYu1ysqosWvDPXSxUNFsCD/myXlPOIn?=
 =?us-ascii?Q?Oyva3gwUKE41pvmc5Q0H/0IW2sh6EXTkMkKegsF9sB8hXILi7VTux7sc0mcI?=
 =?us-ascii?Q?qCtT2U6Z89vaP3JqJIcwSGaamvZ2k7L+YOyELln2FFRt0C7D/LVk36+g5qji?=
 =?us-ascii?Q?l1nPJWrzWwbt41r1i41xCq5igwrLJwlr9psyZhAXS548DlCG4xZUcf35VCxf?=
 =?us-ascii?Q?MblUWXI3n0Qd53YosXDVHquY63kN/JKsoj9q9U5VX4Gbm9m1P3Sj32S+ui+C?=
 =?us-ascii?Q?WP6IOjfbfgnWyfmIkbRTH/P6+lbfwnl8I27dqTdKWh+WO1vA8dcI8I3wIozf?=
 =?us-ascii?Q?qywMTkbzJiBHdR/NJhovDuguLvVsK/ez4U32GzFWXSGVvuJAw3gYv2jf8hoB?=
 =?us-ascii?Q?+1ITnFJb8Ftc1mAdPYsERlJ8wK/hQswve1Eq7Kh5ssFdjJU5TWdZ5SVsRnPQ?=
 =?us-ascii?Q?lsVtqA419kY7LIFBOrlbFH2cTaLAdh9AZ2FE4hENTCImY/Cq8z5FM4UcbKFf?=
 =?us-ascii?Q?YZ2TaKfHr7hMtSINruoDCmW7jGDDrt2dg/BWITvbOhinaVwD82n3LvYrM1uP?=
 =?us-ascii?Q?Y63fLHMU7SI1Z+AQpQ8S+drQGvBJ5V4s2dc0xnJyS1NAioWLGgvui3tKiIaj?=
 =?us-ascii?Q?HXhUophjMJg3g7M3E8CT2VTLWuXAnD+3015jqxN02finO5B2Jxe4c8HIOJuq?=
 =?us-ascii?Q?U5yLRR3VVHJL/kNf3buRdxS7agP+lAHpW87dKoJTl0YBc87rVD9DBAAhKCep?=
 =?us-ascii?Q?o4PN0Hl9jC8vsqj0OWH2AyziLav2DQfzYQKl8oUgFNj9C+ECgIcI9UtulfaK?=
 =?us-ascii?Q?zbuKkW0fNVCn672OS35Fg4aBwPQDCKlUVk2yeNGS7b25R/Wq/T57yTWNyXJL?=
 =?us-ascii?Q?0PooJtiUJuHelo275dmhzdQLu5Tn7ViUwfMofH9pZ3svx0Xbw6O6hHnujrSa?=
 =?us-ascii?Q?NXPLExbJ9GecjVy5/1AV07bD+byLCoKdYUk5+f+mCgIF5p8NwLpi/11cR3fa?=
 =?us-ascii?Q?sKnMfDxWTOgJ27s7HIkCJXbF2WBrpPTUKe05iBx23RTf0XKI5NntjOOTTVR5?=
 =?us-ascii?Q?acmTNMMA9Jbp+PIeF3EfxLPZTS1qw/eEHNMeKbSm1noNtnESEHB85gTI2PDi?=
 =?us-ascii?Q?9Lpn0Om23aR86sBMxd67gTI4f+3RbZ1UPxiNl1FExhQSqahvnBoZbruGFN9H?=
 =?us-ascii?Q?OzJJqWVrkYZKsokeR/1JyU8QBmkXYYq80QGS/YDYvpMP+JOA7OTFVmu1EqOC?=
 =?us-ascii?Q?/UD4iAJ0d2qZAjvRyUzEKun2K5EbwhWgzNu6fV6dPTQQGSl+Y40yAn3tUCGb?=
 =?us-ascii?Q?i1YutqYaYiAqv3VlEimqontDVWx6mAD2i5R+MoC289MumnzZIlwPsxHHJpIr?=
 =?us-ascii?Q?7HZidYN4IWWyiF/DfdFWo+/RPo83eOIWBGKdzgWChdw3JGEUQRvxIYCq6g4Z?=
 =?us-ascii?Q?pdhVQpqOUztmFxX/x2BvL45kJgLg9UUvcVpU2+GXuyGCtE6szelHybLJPX03?=
 =?us-ascii?Q?eVuagTQnopXLxE4mcmlKajaZAwGYiNlGcArI974NBUWNom4tnJWlw/bhsECd?=
 =?us-ascii?Q?jbHgjZ/cwF6QCKlgFDe0DU9QUW9+sYs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f00c3c8-b933-42c3-dce1-08da2c593547
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2022 16:31:28.3335
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ObHgXyuSlIgEc0qNM9anb5aTuPuXpO7mM3jLxzoVhpGRn+DwKJLeffyoloW/6KpZmMFLFYseJglkQAw8bC/8m4r2P11WHmi5z5Zi3ndStQE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6479
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 02/05/2022 09:30, David Sterba wrote:=0A=
> On Mon, May 02, 2022 at 05:16:59PM +0200, David Sterba wrote:=0A=
>> On Sun, May 01, 2022 at 08:22:41PM +0000, Johannes Thumshirn wrote:=0A=
>>> On 29/04/2022 11:32, David Sterba wrote:=0A=
>>>> diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h=0A=
>>>> index fdbfe801dbe2..1fa40ab561df 100644=0A=
>>>> --- a/fs/btrfs/extent_io.h=0A=
>>>> +++ b/fs/btrfs/extent_io.h=0A=
>>>> @@ -266,7 +266,7 @@ struct io_failure_record {=0A=
>>>>  	u64 start;=0A=
>>>>  	u64 len;=0A=
>>>>  	u64 logical;=0A=
>>>> -	unsigned long bio_flags;=0A=
>>>> +	unsigned int compress_type;=0A=
>>>>  	int this_mirror;=0A=
>>>>  	int failed_mirror;=0A=
>>>>  };=0A=
>>>=0A=
>>>=0A=
>>> Why 'unsigned int' and not 'enum btrfs_compression_type'?=0A=
>>=0A=
>> Good point I'll change it, though it's not used almost anywhere else.=0A=
> =0A=
> I'll fix up the 2 following patches as well, the type switch in parameter=
s.=0A=
> =0A=
=0A=
Cool thanks, I was about to ask.=0A=
