Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2B3E3CF14C
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Jul 2021 03:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237910AbhGTApr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Jul 2021 20:45:47 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:29650 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241727AbhGTAn6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Jul 2021 20:43:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1626744276;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tbLBkUs+oqJI8+rJfCpMKFpSdiKusv77WgyFbaGeZ7s=;
        b=HuZ50T3A5gVR2cWHkuBm4KPbcZIbkWJFC8GziXVp5REKt5LVkcqytD/iSGtpIroWLyXhNG
        OiT3ZHnvPfOljq4cGI6CEJSQLeMFGfWrMYXHqq3bhWNPryT2sjid3gkcd5QRq/a45Ouztj
        M3d6xiQOyaF8JEZDEPf7R6mTZYqhM48=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2111.outbound.protection.outlook.com [104.47.17.111])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-37-L0XX--17PAuGR0XtcVa3ug-1; Tue, 20 Jul 2021 03:24:35 +0200
X-MC-Unique: L0XX--17PAuGR0XtcVa3ug-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xr1i+jYIN3NwhaUF8XfqSLlNl6epz1FqgQ21oojvagRFaYYww10bEDeWf+EYQGxBbanBUPm4Daj363hQBi6/qsEe+YL6Co+ztZ7dJIDP4RKV9+OCPgN9RVAeZqOnwK16fETMVwbenLNU3tvWy562s62+m8CCumCAjIXtm6tuMG2jHr18k7Uxtm6PBi+7qhNfCgO8OWHDTUF83MjRQTC5+O2FSCBQeW4rckrncuwRTGXFGDWws4f86sn/BMmgb85fZcYOekxg1r7GQHi4AX0vDv3KPRrpESSEXPKS+wh2BhsjrzlJ5A1Y1JuAXZyQlhxJuSdrVNyfEFcqiQ6sEv9k5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2YbMLQpmJuMnry2QNKQkM7+pBtpgDcF6QkJXnRmOSG8=;
 b=j8Mto4O46EnQepnuDv6YYTez7ZinlRndwNfdTNXia8wosjw0qXJkr3NJOhpqZ+otG5eeawfCK9Dgk++W40K4xxn6n23A3t+ECMBYhOcdCnyRpeYW+m+bY9D44HpxZ9yGu0vp51P35GJD2/Uk8s0U0CDd9r1xxyejfGVzPKEbSmctzsnehY/9CTLIBsH8kCsI4BlPl+zmuEB4YDxLv3MbXfvVx9WdA2Tah/oi9lx3Y3DlDhcmpAYpLNJWi2ETvQ+VfmJOiJL2mF0L5CVQiPO62i2mStAKBSnWWQ5ILrIaLnVSnQrzM+OPbW4+vEKABbIXiZzvu55YjqyHuS5GfTRz6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AM6PR0402MB3672.eurprd04.prod.outlook.com (2603:10a6:209:1c::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Tue, 20 Jul
 2021 01:24:33 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::816b:1f6a:c279:1b65]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::816b:1f6a:c279:1b65%3]) with mapi id 15.20.4331.032; Tue, 20 Jul 2021
 01:24:33 +0000
Subject: Re: [PATCH RFC] fstests: allow running custom hooks
To:     "Darrick J. Wong" <djwong@kernel.org>
CC:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <20210719071337.217501-1-wqu@suse.com>
 <20210720011600.GA22384@magnolia>
From:   Qu Wenruo <wqu@suse.com>
Message-ID: <342381aa-9e1f-f81c-f0e4-a72f70f8ac48@suse.com>
Date:   Tue, 20 Jul 2021 09:24:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <20210720011600.GA22384@magnolia>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BYAPR01CA0041.prod.exchangelabs.com (2603:10b6:a03:94::18)
 To AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BYAPR01CA0041.prod.exchangelabs.com (2603:10b6:a03:94::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22 via Frontend Transport; Tue, 20 Jul 2021 01:24:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 280664dd-8927-4393-0297-08d94b1d2168
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3672:
X-Microsoft-Antispam-PRVS: <AM6PR0402MB36728DB2E816D47B0EC6516CD6E29@AM6PR0402MB3672.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: afjdEOlpvM0X/l8dsAVsi7DGy9doWz5mVu11Ma+L78hSLajuOk/TB5DUjy+MvXfVRUrDmTfxFBr0XmxoqB02D3IiDjVlOUyQDoe7AVZVoI8/Ny+5OEHWaSadyyu5LCiHwyOegJicmszbspsuaodi3vbAB4erpjh+fDfCs/Ig8hOq6odoO+nG2KtOfkKREX5amq8Es2eIWZHYU7jnDlvSDYqqec6x6b+EuyKSdqcBLqkj+fh6zUUXwRCxIaOu6ygKBR0o7RKns2E+Vxz51VfJqe7gi2SUOFERvoYdBeMmSWtV6eP3Xz0S7N1XTiPEwxLALiEMDbr9ieQJrPmAJM23bgYBhvS1nC2VKwKBBd5az7NDz/CzFZDruNKuEzxVJVgAhalJWUpAq78dwaL38sn6lto2p+2dGXlsEVoAdMrMSc2KqkB1Mhp1ZLeW4/xNWL5qn1SWC0DERJTNNYsqShomq0DWABECfK7e9jcAeNroZXBz34qVeOUef0I5b+flvbaNisXKMwkD62fM/ut30q8kX7f0W+ZWnUvH1ZadQ1l7Yhl3I0Ycpg2EToCEPNQzTQjkp9WM0jmCZCeZCtvojABQ+QIZAJKdnWfu3SEpM6SCkbBqPyVYklEM5+S/o7KPTJDYdiAm0YBMp+S2vgcPI1TWGVxLd5Pwms75CzrUVe3hmIebLUCw4arNfQOSeRXW+9sbuwYX1IbAtgZb2eQEbQMwqkbrXh8iihRh85D7vUsVugw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(346002)(39860400002)(396003)(366004)(16576012)(66946007)(6486002)(26005)(6666004)(186003)(8676002)(5660300002)(66476007)(8936002)(4326008)(316002)(66556008)(38100700002)(83380400001)(2616005)(36756003)(6916009)(6706004)(956004)(478600001)(31696002)(31686004)(86362001)(2906002)(78286007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vZeg+kIbGXmGD1e6chwAZmhMlu6ym6kWixX3I8i8efbb547lya34j5ZcQ4mM?=
 =?us-ascii?Q?vEFma1RH/NMJ725Ox257bqgo302J+1IyOgnmRl6z1GYfvqerfKw2kF/VtTBv?=
 =?us-ascii?Q?q44X8mTHTv0V6SMZk6evpb+U6oH1tD7gakEk3qyw5qitSqJFjFXRPSyV91gw?=
 =?us-ascii?Q?EYwkQMGdeECEH3tKfFqm8SU8ZRaJI1NiIJ2j2GouL+tMO2nrXjQ0qEMIzezr?=
 =?us-ascii?Q?f+w4cCzhaKPOgepyvyHsu4tcwvQtlaEvUUwguHs0MfHklCWVidhoSXtaUw64?=
 =?us-ascii?Q?BPb97SVyU4f1xehisSe6X+Xf4Ylco3aEar7sR5fhypsRJOTR+t48Bp62e1/A?=
 =?us-ascii?Q?gGII7MalHxN9cCH09o6f7Kx6dZXgG48mhakQLiaeqm8GvXcPqU4qETacIZnX?=
 =?us-ascii?Q?GILHtFcfXzKAXJplkPOv4yy5597HtUJT7kwx9zKAIU06rns+qk7IfLQUTQ/I?=
 =?us-ascii?Q?aL2MNZZeBL5/dEiEiactoH0F+1BZned77dJ8waAgEG01u/mKFznMYHF7JvXr?=
 =?us-ascii?Q?jDrF1v8M5NBpQhulKpGww6iacZVaZyCI24VIlmtEtH/AOqg8KYm21UwmX2WB?=
 =?us-ascii?Q?HLF/qdmnr/eVpid54KW/FJEXU8f1JpjnOBV2VrKXXZOvSW7MEetPeWQajark?=
 =?us-ascii?Q?Xlkxpxd1JOukUG5edv20E3IBM7nQiIx/aZ+J6M42ZjWTpqzIaOVTM3tshkf3?=
 =?us-ascii?Q?gKToX2C1PQjIfP8kkxHNZieQjjzwhb1mw3ro+0ZxEKeam84o0p5ghrOLaiW1?=
 =?us-ascii?Q?n9N0hAMAonOmcQcqZ3pIjFe7wWcHjG+le4VCaaQh0qkW89SGynvFMATewAL3?=
 =?us-ascii?Q?LswbAPJ3n4LRzFJbS5kVtJQdCu5aG3OAN/dIDSabktaMmD2mxAtH/dy/M3Zr?=
 =?us-ascii?Q?FtjI5YOVQJfn2VKQRTXJizT5lBvu05BsdY0WlIj1LM3to6Qjh2/78vs8KWV2?=
 =?us-ascii?Q?1HVFOaeuletkLnSS2P/ARB9mSmB2yXW/IxhHWc9VNXy1RaKIlz/6F7DJQ7Gx?=
 =?us-ascii?Q?XqLrfALpWteh5WOhyVV8chDeXlqb+PKuowvgZaRVDsyL0CylHttPDbG/Db6x?=
 =?us-ascii?Q?o/xQvCy0UE/ssk1L794QR1EvMFs7wWlyz9r+F66Y2RNJ1FZEjiIUxF8Cg2vR?=
 =?us-ascii?Q?dc1IPvTCGPFq6nRwuBBecwf7sNLs7DkPMl8nZJcCdBeKzHzlN/K97ioCQ9bU?=
 =?us-ascii?Q?MaplcV+XF9GVDRth4/PR9ibk90uvByigVrDbi53HRLWU9ZCi02t8im7t3Sia?=
 =?us-ascii?Q?XNq9BRlmcVCNBBo04YnhpJtyjPsvvHDoNgWljQO6SadmzxvpJDar84ZfTrA4?=
 =?us-ascii?Q?v9wqPm3nL74q5F/j2BZpTtaY?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 280664dd-8927-4393-0297-08d94b1d2168
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2021 01:24:33.8813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zliZr2rOJzbFUw6LNBRm9o7VzQopDZEztLSqcsSRWVPO5mMz1Q28qRA8gDTS0PAA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3672
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/20 =E4=B8=8A=E5=8D=889:16, Darrick J. Wong wrote:
> On Mon, Jul 19, 2021 at 03:13:37PM +0800, Qu Wenruo wrote:
>> This patch will allow fstests to run custom hooks before and after each
>> test case.
>>
>> These hooks will need to follow requirements:
>>
>> - Both hook files needs to be executable
>>    Or they will just be ignored
>>
>> - Stderr and stdout will be redirected to "$seqres.full"
>>    With extra separator to distinguish the hook output with real
>>    test output
>>
>>    Thus if any of the hook is specified, all tests will generate
>>    "$seqres.full" which may increase the disk usage for results.
>>
>> - Error in hooks script will be ignored completely
>>
>> - Environment variable "$HOOK_TEMP" will be exported for both hooks
>>    And the variable will be ensured not to change for both hooks.
>>
>>    Thus it's possible to store temporary values between the two hooks,
>>    like pid.
>>
>> - Start hook has only one parameter passed in
>>    $1 is "$seq" from "check" script. The content will the path of curren=
t
>>    test case. E.g "tests/btrfs/001"
>>
>> - End hook has two parameters passed in
>>    $1 is the same as start hook.
>>    $2 is the return value of the test case.
>>    NOTE: $2 doesn't take later golden output mismatch check nor dmesg/km=
emleak
>>    check.
>>
>> For more info, please refer to "README.hooks".
>>
>> Also update .gitignore to ignore "hooks/start.hook" and "hooks/end.hook"
>> so that one won't accidentally submit the debug hook.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> Instead of previous attempt to manually utilize sysfs interface of
>> ftrace, this time just add some hooks to allow one to do whatever they
>> want.
>>
>> RFC for how everything should be passed to hooks.
>> Currently it's using a mixed method, $seq/$sts is passed as paramaters,
>> while HOOK_TMP is passed as environmental variable.
>>
>> Not sure what's the recommended way for hooks.
>> ---
>>   .gitignore      |  4 +++
>>   README.hooks    | 72 +++++++++++++++++++++++++++++++++++++++++++++++++
>>   check           |  5 ++++
>>   common/preamble |  4 ---
>>   common/rc       | 43 +++++++++++++++++++++++++++++
>>   5 files changed, 124 insertions(+), 4 deletions(-)
>>   create mode 100644 README.hooks
>>
>> diff --git a/.gitignore b/.gitignore
>> index 2d72b064..99905ff9 100644
>> --- a/.gitignore
>> +++ b/.gitignore
>> @@ -201,3 +201,7 @@ tags
>>   # cscope files
>>   cscope.*
>>   ncscope.*
>> +
>> +# hook scripts
>> +/hooks/start.hook
>> +/hooks/end.hook
>> diff --git a/README.hooks b/README.hooks
>> new file mode 100644
>> index 00000000..be92a7d7
>> --- /dev/null
>> +++ b/README.hooks
>> @@ -0,0 +1,72 @@
>> +To run extra commands before and after each test case, there is the
>> +'hooks/start.hook' and 'hooks/end.hook' files for such usage.
>> +
>> +Some notes for those two hooks:
>> +
>> +- Both hook files needs to be executable
>> +  Or they will just be ignored
>> +
>> +- Stderr and stdout will be redirected to "$seqres.full"
>> +  With extra separator to distinguish the hook output with real
>> +  test output
>> +
>> +  Thus if any of the hook is specified, all tests will generate
>> +  "$seqres.full" which may increase the disk usage for results.
>> +
>> +- Error in hooks script will be ignored completely
>> +
>> +- Environment variable "$HOOK_TEMP" will be exported for both hooks
>> +  And the variable will be ensured not to change for both hooks.
>> +
>> +  Thus it's possible to store temporary values between the two hooks,
>> +  like pid.
>> +
>> +- Start hook has only one parameter passed in
>> +  $1 is "$seq" from "check" script. The content will the path of curren=
t
>> +  test case. E.g "tests/btrfs/001"
>> +
>> +- End hook has two parameters passed in
>> +  $1 is the same as start hook.
>> +  $2 is the return value of the test case.
>> +  NOTE: $2 doesn't take later golden output mismatch check nor dmesg/km=
emleak
>> +  check.
>> +
>> +The very basic test hooks would look like:
>> +
>> +hooks/start.hook:
>> +  #!/bin/bash
>> +  seq=3D$1
>> +  echo "HOOK_TMP=3D$HOOK_TMP"
>> +  echo "seq=3D$seq"
>> +
>> +hooks/end.hook:
>> +  #!/bin/bash
>> +  seq=3D$1
>> +  sts=3D$2
>> +  echo "HOOK_TMP=3D$HOOK_TMP"
>> +  echo "seq=3D$seq"
>> +  echo "sts=3D$sts"
>> +
>> +Then run test btrfs/001 and btrfs/002, their "$seqres.full" would look =
like:
>> +
>> +result/btrfs/001.full:
>> +  =3D=3D=3D Running start hook =3D=3D=3D
>> +  HOOK_TMP=3D/tmp/78973.hook
>> +  seq=3Dtests/btrfs/001
>> +  =3D=3D=3D Start hook finished =3D=3D=3D
>> +  =3D=3D=3D Running end hook =3D=3D=3D
>> +  HOOK_TMP=3D/tmp/78973.hook
>> +  seq=3Dtests/btrfs/001
>> +  sts=3D0
>> +  =3D=3D=3D End hook finished =3D=3D=3D
>> +
>> +result/btrfs/002.full:
>> +  =3D=3D=3D Running start hook =3D=3D=3D
>> +  HOOK_TMP=3D/tmp/78973.hook
>> +  seq=3Dtests/btrfs/002
>> +  =3D=3D=3D Start hook finished =3D=3D=3D
>> +  =3D=3D=3D Running end hook =3D=3D=3D
>> +  HOOK_TMP=3D/tmp/78973.hook
>> +  seq=3Dtests/btrfs/002
>> +  sts=3D0
>> +  =3D=3D=3D End hook finished =3D=3D=3D
>> diff --git a/check b/check
>> index bb7e030c..f24906f5 100755
>> --- a/check
>> +++ b/check
>> @@ -846,6 +846,10 @@ function run_section()
>>   		# to be reported for each test
>>   		(echo 1 > $DEBUGFS_MNT/clear_warn_once) > /dev/null 2>&1
>>  =20
>> +		# Remove previous $seqres.full before start hook
>> +		rm -f $seqres.full
>> +
>> +		_run_start_hook
>=20
> Seeing as we now have standardized preamble and cleanup in every single
> test, why don't you run this from _begin_fstest and modify
> _register_cleanup to run _run_end_hook from the trap handler?

That's a great advice.

As my mindset is still in the pre-preamble age...

>=20
> This way the start hooks run from within each test and therefore can
> modify the test's environment (as opposed to ./check's environment; the
> two are /not/ the same thing!) and/or _notrun the test like Ted wants.

That would be super awesome, although it means the hook user should also=20
be extra cautious not to crash the hook itself...

Thanks,
Qu

>=20
> (Granted I wonder why not use an exclude list, because I bet my 3.10
> kernel has patches that yours doesn't, so kernel versions aren't all
> that meaningful...)
>=20
> --D
>=20
>>   		if [ "$DUMP_OUTPUT" =3D true ]; then
>>   			_run_seq 2>&1 | tee $tmp.out
>>   			# Because $? would get tee's return code
>> @@ -854,6 +858,7 @@ function run_section()
>>   			_run_seq >$tmp.out 2>&1
>>   			sts=3D$?
>>   		fi
>> +		_run_end_hook
>>  =20
>>   		if [ -f core ]; then
>>   			_dump_err_cont "[dumped core]"
>> diff --git a/common/preamble b/common/preamble
>> index 66b0ed05..41a12060 100644
>> --- a/common/preamble
>> +++ b/common/preamble
>> @@ -56,8 +56,4 @@ _begin_fstest()
>>   	_register_cleanup _cleanup
>>  =20
>>   	. ./common/rc
>> -
>> -	# remove previous $seqres.full before test
>> -	rm -f $seqres.full
>> -
>>   }
>> diff --git a/common/rc b/common/rc
>> index d4b1f21f..ec434aa5 100644
>> --- a/common/rc
>> +++ b/common/rc
>> @@ -4612,6 +4612,49 @@ _require_names_are_bytes() {
>>           esac
>>   }
>>  =20
>> +_run_start_hook()
>> +{
>> +	if [[ ! -d "hooks" ]]; then
>> +		return
>> +	fi
>> +
>> +	if [[ ! -x "hooks/start.hook" ]]; then
>> +		return
>> +	fi
>> +
>> +	# Export $HOOK_TMP for hooks, here we add ".hook" suffix to "$tmp",
>> +	# so we won't overwrite any existing $tmp.* files
>> +	export HOOK_TMP=3D$tmp.hook
>> +
>> +	echo "=3D=3D=3D Running start hook =3D=3D=3D" >> $seqres.full
>> +	# $1 is alwasy $seq
>> +	./hooks/start.hook $seq >> $seqres.full 2>&1
>> +	echo "=3D=3D=3D Start hook finished =3D=3D=3D" >> $seqres.full
>> +	unset HOOK_TMP
>> +}
>> +
>> +_run_end_hook()
>> +{
>> +	if [[ ! -d "hooks" ]]; then
>> +		return
>> +	fi
>> +
>> +	if [[ ! -x "hooks/end.hook" ]]; then
>> +		return
>> +	fi
>> +
>> +	# Export $HOOK_TMP for hooks, here we add ".hook" suffix to "$tmp",
>> +	# so we won't overwrite any existing $tmp.* files
>> +	export HOOK_TMP=3D$tmp.hook
>> +
>> +	echo "=3D=3D=3D Running end hook =3D=3D=3D" >> "$seqres.full"
>> +	# $1 is alwasy $seq
>> +	# $2 is alwasy $sts
>> +	./hooks/end.hook $seq $sts >> "$seqres.full" 2>&1
>> +	echo "=3D=3D=3D End hook finished =3D=3D=3D" >> "$seqres.full"
>> +	unset HOOK_TMP
>> +}
>> +
>>   init_rc
>>  =20
>>   ######################################################################=
##########
>> --=20
>> 2.31.1
>>
>=20

