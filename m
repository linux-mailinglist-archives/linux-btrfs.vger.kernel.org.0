Return-Path: <linux-btrfs+bounces-5334-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 577818D281F
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 May 2024 00:38:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C37461F2662F
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 May 2024 22:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1ACF13E3E3;
	Tue, 28 May 2024 22:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KYhmHs1s"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B06140389
	for <linux-btrfs@vger.kernel.org>; Tue, 28 May 2024 22:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716935878; cv=none; b=pCUErVGcqsGAWkJxn6j2QWMEjvYld00bNTwYk1GJ4lLxxhfZ0HNbky2fT0piYCz1wmCj7PRI9sL2Fx1ZeKZKe03bYm6oVagOlsdiWGfIBxF/+Gu2WiEh3XIj8LXoje/wTjeQhWx5o8iSFYF7sy5hvmcCFq8PuB9mZfJrRM+cR9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716935878; c=relaxed/simple;
	bh=h0oJbZGASlF6DeFjral+nNflNNppptQROKeRJzlCay0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=omMuJFZsEbHVrbqUJfAFBarPm44pp53cPGRFGY/OW+xptdWH+WPhy0yz0hHQ4DgamZ9JVKc2i9M3c7DAvVzveQEuEO/Clf28U4NLA971/2Q0+ZtgbJaGB3/GDd71yuWzEwULuDGu0bjOEHwslqvmFb71D+JXlOpe9hS9febEhXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KYhmHs1s; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716935876; x=1748471876;
  h=from:to:subject:date:message-id:mime-version;
  bh=h0oJbZGASlF6DeFjral+nNflNNppptQROKeRJzlCay0=;
  b=KYhmHs1sWbtMUtgwmKtN5xJrimHtoJRYFRCuNl70QG2+/2TBppaRL78z
   sH3Ui9G4Hruw6SQ9w1079EoxSGDxnkEmhSbp0e2H7oCoaRuAB7ANaKAEa
   5rq6VZnUKjRCsu1S32mwASPhT1bEFHHzwe065NLMCsnFFpPpKP08rcSjw
   y5yOZldjYvczDnX7BnpIgFVjyGJIUt1TiG10QYkpojlfHws+wX/+KrUn7
   OsZ2FkutZAYgAGOD2WEBmJSxbv9/sDbmqBA+peWyabnEYLUdxiRdXuORe
   2CX9l9o1q31tYjBkWX23Y8eneXMyT1UAfKy4FpVHuf+hLR7/zBvDA0Nqp
   Q==;
X-CSE-ConnectionGUID: XbYJbR+dSDOQeM4Vy4EVTw==
X-CSE-MsgGUID: HyWUdv2bSdOY0gKhY1rreg==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="17102902"
X-IronPort-AV: E=Sophos;i="6.08,196,1712646000"; 
   d="p7s'346?scan'346,208,346";a="17102902"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 15:37:55 -0700
X-CSE-ConnectionGUID: F5+mdhphSsmwvDryb967ew==
X-CSE-MsgGUID: QM7F3jmtQ1ahRtxiSQPyHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,196,1712646000"; 
   d="p7s'346?scan'346,208,346";a="58406760"
Received: from tjmaciei-mobl5.ger.corp.intel.com (HELO tjmaciei-mobl5.localnet) ([10.125.110.251])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 15:37:54 -0700
From: Thiago Macieira <thiago.macieira@intel.com>
To: linux-btrfs@vger.kernel.org
Subject:
 [6.9 behaviour change] subvolume device ID no longer present in
 /proc/self/mountinfo
Date: Tue, 28 May 2024 19:37:45 -0300
Message-ID: <2548140.Uh0CODmnKu@tjmaciei-mobl5>
Organization: Intel Corporation
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3439063.sfYGdeWWPf";
 micalg="sha256"; protocol="application/pkcs7-signature"

--nextPart3439063.sfYGdeWWPf
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Re: https://bugreports.qt.io/browse/QTBUG-125721

Summary: the submodule's block device ID is no longer present in 
/proc/self/mountinfo. Instead, the root device ID is now shown and that does 
not match what you get from stat().

Qt's QStorageInfo class used to use this matching to detect when a filesystem 
had been mounted over and were no longer accessible. With the change in kernel 
behaviour, QStorageInfo always concludes all btrfs subvolumes are mounted 
over.

When you mount a subvolume, the subvolume gets its own device ID:

# mount -o loop fs foo    
# btrfs sub create foo/@
Create subvolume 'foo/@'
# btrfs sub create foo/@home
Create subvolume 'foo/@home'
# mkdir foo/@/home
# umount foo 

# mount -o loop,subvol=/@ fs foo
# mount -o loop,subvol=/@home fs foo/home
# stat -c %d foo
149
# stat -c %d foo/home/
94

In 6.8.8:
# grep loop0 /proc/self/mountinfo 
340 35 0:149 /@ /tmp/foo rw,relatime shared:310 - btrfs /dev/loop0 
rw,ssd,discard=async,space_cache=v2,subvolid=256,subvol=/@
450 340 0:94 /@home /tmp/foo/home rw,relatime shared:1049 - btrfs /dev/loop0 
rw,ssd,discard=async,space_cache=v2,subvolid=257,subvol=/@home

In 6.9.1:
$ stat -c %d foo foo/home; grep loop0 /proc/self/mountinfo
153
154
486 58 0:151 /@ /tmp/foo rw,relatime shared:445 - btrfs /dev/loop0 
rw,ssd,discard=async,space_cache=v2,subvolid=256,subvol=/@
496 486 0:151 /@home /tmp/foo/home rw,relatime shared:455 - btrfs /dev/loop0 
rw,ssd,discard=async,space_cache=v2,subvolid=257,subvol=/@home

Note that how device 151 is not the same as reported by stat().

I need to know if this behaviour is expected and will remain, or if it will be 
fixed, or alternatively if it is a configuration problem somewhere. If it is 
expected, I will need to find a workaround to solving my problem.

Thank you in advance, best regards,
-- 
Thiago Macieira - thiago.macieira (AT) intel.com
  Principal Engineer - Intel DCAI Fleet Engineering and Quality

--nextPart3439063.sfYGdeWWPf
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIIUHAYJKoZIhvcNAQcCoIIUDTCCFAkCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghFlMIIFgTCCBGmgAwIBAgIQOXJEOvkit1HX02wQ3TE1lTANBgkqhkiG9w0BAQwFADB7MQswCQYD
VQQGEwJHQjEbMBkGA1UECAwSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHDAdTYWxmb3JkMRow
GAYDVQQKDBFDb21vZG8gQ0EgTGltaXRlZDEhMB8GA1UEAwwYQUFBIENlcnRpZmljYXRlIFNlcnZp
Y2VzMB4XDTE5MDMxMjAwMDAwMFoXDTI4MTIzMTIzNTk1OVowgYgxCzAJBgNVBAYTAlVTMRMwEQYD
VQQIEwpOZXcgSmVyc2V5MRQwEgYDVQQHEwtKZXJzZXkgQ2l0eTEeMBwGA1UEChMVVGhlIFVTRVJU
UlVTVCBOZXR3b3JrMS4wLAYDVQQDEyVVU0VSVHJ1c3QgUlNBIENlcnRpZmljYXRpb24gQXV0aG9y
aXR5MIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAgBJlFzYOw9sIs9CsVw127c0n00yt
UINh4qogTQktZAnczomfzD2p7PbPwdzx07HWezcoEStH2jnGvDoZtF+mvX2do2NCtnbyqTsrkfji
b9DsFiCQCT7i6HTJGLSR1GJk23+jBvGIGGqQIjy8/hPwhxR79uQfjtTkUcYRZ0YIUcuGFFQ/vDP+
fmyc/xadGL1RjjWmp2bIcmfbIWax1Jt4A8BQOujM8Ny8nkz+rwWWNR9XWrf/zvk9tyy29lTdyOcS
Ok2uTIq3XJq0tyA9yn8iNK5+O2hmAUTnAU5GU5szYPeUvlM3kHND8zLDU+/bqv50TmnHa4xgk97E
xwzf4TKuzJM7UXiVZ4vuPVb+DNBpDxsP8yUmazNt925H+nND5X4OpWaxKXwyhGNVicQNwZNUMBkT
rNN9N6frXTpsNVzbQdcS2qlJC9/YgIoJk2KOtWbPJYjNhLixP6Q5D9kCnusSTJV882sFqV4Wg8y4
Z+LoE53MW4LTTLPtW//e5XOsIzstAL81VXQJSdhJWBp/kjbmUZIO8yZ9HE0XvMnsQybQv0FfQKlE
RPSZ51eHnlAfV1SoPv10Yy+xUGUJ5lhCLkMaTLTwJUdZ+gQek9QmRkpQgbLevni3/GcV4clXhB4P
Y9bpYrrWX1Uu6lzGKAgEJTm4Diup8kyXHAc/DVL17e8vgg8CAwEAAaOB8jCB7zAfBgNVHSMEGDAW
gBSgEQojPpbxB+zirynvgqV/0DCktDAdBgNVHQ4EFgQUU3m/WqorSs9UgOHYm8Cd8rIDZsswDgYD
VR0PAQH/BAQDAgGGMA8GA1UdEwEB/wQFMAMBAf8wEQYDVR0gBAowCDAGBgRVHSAAMEMGA1UdHwQ8
MDowOKA2oDSGMmh0dHA6Ly9jcmwuY29tb2RvY2EuY29tL0FBQUNlcnRpZmljYXRlU2VydmljZXMu
Y3JsMDQGCCsGAQUFBwEBBCgwJjAkBggrBgEFBQcwAYYYaHR0cDovL29jc3AuY29tb2RvY2EuY29t
MA0GCSqGSIb3DQEBDAUAA4IBAQAYh1HcdCE9nIrgJ7cz0C7M7PDmy14R3iJvm3WOnnL+5Nb+qh+c
li3vA0p+rvSNb3I8QzvAP+u431yqqcau8vzY7qN7Q/aGNnwU4M309z/+3ri0ivCRlv79Q2R+/czS
AaF9ffgZGclCKxO/WIu6pKJmBHaIkU4MiRTOok3JMrO66BQavHHxW/BBC5gACiIDEOUMsfnNkjcZ
7Tvx5Dq2+UUTJnWvu6rvP3t3O9LEApE9GQDTF1w52z97GA1FzZOFli9d31kWTz9RvdVFGD/tSo7o
BmF0Ixa1DVBzJ0RHfxBdiSprhTEUxOipakyAvGp4z7h/jnZymQyd/teRCBaho1+VMIIGEDCCA/ig
AwIBAgIQTZQsENQ74JQJxYEtOisGTzANBgkqhkiG9w0BAQwFADCBiDELMAkGA1UEBhMCVVMxEzAR
BgNVBAgTCk5ldyBKZXJzZXkxFDASBgNVBAcTC0plcnNleSBDaXR5MR4wHAYDVQQKExVUaGUgVVNF
UlRSVVNUIE5ldHdvcmsxLjAsBgNVBAMTJVVTRVJUcnVzdCBSU0EgQ2VydGlmaWNhdGlvbiBBdXRo
b3JpdHkwHhcNMTgxMTAyMDAwMDAwWhcNMzAxMjMxMjM1OTU5WjCBljELMAkGA1UEBhMCR0IxGzAZ
BgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEYMBYGA1UEChMPU2Vj
dGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVTZWN0aWdvIFJTQSBDbGllbnQgQXV0aGVudGljYXRpb24g
YW5kIFNlY3VyZSBFbWFpbCBDQTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMo87ZQK
Qf/e+Ua56NY75tqSvysQTqoavIK9viYcKSoq0s2cUIE/bZQu85eoZ9X140qOTKl1HyLTJbazGl6n
BEibivHbSuejQkq6uIgymiqvTcTlxZql19szfBxxo0Nm9l79L9S+TZNTEDygNfcXlkHKRhBhVFHd
JDfqB6Mfi/Wlda43zYgo92yZOpCWjj2mz4tudN55/yE1+XvFnz5xsOFbme/SoY9WAa39uJORHtbC
0x7C7aYivToxuIkEQXaumf05Vcf4RgHs+Yd+mwSTManRy6XcCFJE6k/LHt3ndD3sA3If/JBz6OX2
ZebtQdHnKav7Azf+bAhudg7PkFOTuRMCAwEAAaOCAWQwggFgMB8GA1UdIwQYMBaAFFN5v1qqK0rP
VIDh2JvAnfKyA2bLMB0GA1UdDgQWBBQJwPL8C9qU21/+K9+omULPyeCtADAOBgNVHQ8BAf8EBAMC
AYYwEgYDVR0TAQH/BAgwBgEB/wIBADAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwEQYD
VR0gBAowCDAGBgRVHSAAMFAGA1UdHwRJMEcwRaBDoEGGP2h0dHA6Ly9jcmwudXNlcnRydXN0LmNv
bS9VU0VSVHJ1c3RSU0FDZXJ0aWZpY2F0aW9uQXV0aG9yaXR5LmNybDB2BggrBgEFBQcBAQRqMGgw
PwYIKwYBBQUHMAKGM2h0dHA6Ly9jcnQudXNlcnRydXN0LmNvbS9VU0VSVHJ1c3RSU0FBZGRUcnVz
dENBLmNydDAlBggrBgEFBQcwAYYZaHR0cDovL29jc3AudXNlcnRydXN0LmNvbTANBgkqhkiG9w0B
AQwFAAOCAgEAQUR1AKs5whX13o6VbTJxaIwA3RfXehwQOJDI47G9FzGR87bjgrShfsbMIYdhqpFu
SUKzPM1ZVPgNlT+9istp5UQNRsJiD4KLu+E2f102qxxvM3TEoGg65FWM89YN5yFTvSB5PelcLGnC
LwRfCX6iLPvGlh9j30lKzcT+mLO1NLGWMeK1w+vnKhav2VuQVHwpTf64ZNnXUF8p+5JJpGtkUG/X
fdJ5jR3YCq8H0OPZkNoVkDQ5CSSF8Co2AOlVEf32VBXglIrHQ3v9AAS0yPo4Xl1FdXqGFe5TcDQS
qXh3TbjugGnG+d9yZX3lB8bwc/Tn2FlIl7tPbDAL4jNdUNA7jGee+tAnTtlZ6bFz+CsWmCIb6j6l
DFqkXVsp+3KyLTZGXq6F2nnBtN4t5jO3ZIj2gpIKHAYNBAWLG2Q2fG7Bt2tPC8BLC9WIM90gbMhA
mtMGquITn/2fORdsNmaV3z/sPKuIn8DvdEhmWVfh0fyYeqxGlTw0RfwhBlakdYYrkDmdWC+XszE1
9GUi8K8plBNKcIvyg2omAdebrMIHiAHAOiczxX/aS5ABRVrNUDcjfvp4hYbDOO6qHcfzy/uY0fO5
ssebmHQREJJA3PpSgdVnLernF6pthJrGkNDPeUI05svqw1o5A2HcNzLOpklhNwZ+4uWYLcAi14AC
HuVvJsmzNicwggXIMIIEsKADAgECAhEAmNKe/GMzrd42++mphuFrQTANBgkqhkiG9w0BAQsFADCB
ljELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2Fs
Zm9yZDEYMBYGA1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVTZWN0aWdvIFJTQSBDbGll
bnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQTAeFw0yNDAyMDYwMDAwMDBaFw0y
NTAyMDUyMzU5NTlaMIHBMQswCQYDVQQGEwJVUzETMBEGA1UECBMKQ2FsaWZvcm5pYTEaMBgGA1UE
ChMRSW50ZWwgQ29ycG9yYXRpb24xGTAXBgNVBGETEE5UUlVTK0RFLTIxODkwNzQxKDAmBgkqhkiG
9w0BCQEWGXRoaWFnby5tYWNpZWlyYUBpbnRlbC5jb20xETAPBgNVBAQTCE1hY2llaXJhMQ8wDQYD
VQQqEwZUaGlhZ28xGDAWBgNVBAMTD1RoaWFnbyBNYWNpZWlyYTCCASIwDQYJKoZIhvcNAQEBBQAD
ggEPADCCAQoCggEBAMo12vQHELQBeRYa1TFMGDXaEfa9hvHsrHbdw3bRlsLOlBkilqmWoNIY8Eg+
aKfsX1R8j4TBfZL4O8Kbj9zuTyOjxMoZ0sy9aqLESyvCndTxLkXTuD9ucRpzyaONTVDpkcPvmzCn
Pfu/wrjVgCjJgSGhP2UcftOtJMpxVq1h2xLxL+PIK6vu1QcUC+KGsAJksJwpohxSXQRXnySXEkAY
xOOqjPu5aD84dSkkjm+WiLxYn7b3kpIM+cKYXHed8VazQj3fgNoetpAd8xbxomb58Eb0xETFle+H
iVCEZlyb4WQXXvPJLQvOcG2GyRlD0lA4wQXtBumI/FniVI+dRl40hHkCAwEAAaOCAeIwggHeMB8G
A1UdIwQYMBaAFAnA8vwL2pTbX/4r36iZQs/J4K0AMB0GA1UdDgQWBBRWBSSvvmYM9fi+EyssysN/
bREXwDAOBgNVHQ8BAf8EBAMCBaAwDAYDVR0TAQH/BAIwADAdBgNVHSUEFjAUBggrBgEFBQcDBAYI
KwYBBQUHAwIwUAYDVR0gBEkwRzA6BgwrBgEEAbIxAQIBCgQwKjAoBggrBgEFBQcCARYcaHR0cHM6
Ly9zZWN0aWdvLmNvbS9TTUlNRUNQUzAJBgdngQwBBQMCMFoGA1UdHwRTMFEwT6BNoEuGSWh0dHA6
Ly9jcmwuc2VjdGlnby5jb20vU2VjdGlnb1JTQUNsaWVudEF1dGhlbnRpY2F0aW9uYW5kU2VjdXJl
RW1haWxDQS5jcmwwgYoGCCsGAQUFBwEBBH4wfDBVBggrBgEFBQcwAoZJaHR0cDovL2NydC5zZWN0
aWdvLmNvbS9TZWN0aWdvUlNBQ2xpZW50QXV0aGVudGljYXRpb25hbmRTZWN1cmVFbWFpbENBLmNy
dDAjBggrBgEFBQcwAYYXaHR0cDovL29jc3Auc2VjdGlnby5jb20wJAYDVR0RBB0wG4EZdGhpYWdv
Lm1hY2llaXJhQGludGVsLmNvbTANBgkqhkiG9w0BAQsFAAOCAQEAKzjHXLQRIbYpew1ssPD4R1zv
Nbf/fUtowwlsLQnR1E/c8vcKbAmbQBVPvt/i8FdkM9mgYWXFnuWXaOu07GkfFOdrPSm+Pxy/gSoM
e/sXe1FcB4Nrjh+RK8+RYjBFcLKVFCtVuwBjhPOZ1x9aNiFkEul/bVkhA6is3hXwcLWfNcIVXjUP
0cyCIR0dDzfitsclSminJv3exg1U+gitix4MZ4bfxqCN880VW5ZXJjgam24yzx+ShP14wsKLmqSh
fxLHGrH4YlL0QikD1t2w858ya1UXMJKZM/0jNUKD4SsT1ck6Jm/E0F5+8TdgShty93FkUXGPFIqK
S12rg80RKka+pTGCAnswggJ3AgEBMIGsMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRl
ciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQx
PjA8BgNVBAMTNVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVt
YWlsIENBAhEAmNKe/GMzrd42++mphuFrQTANBglghkgBZQMEAgEFAKCBoDAYBgkqhkiG9w0BCQMx
CwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNDA1MjgyMjM3NDVaMC8GCSqGSIb3DQEJBDEi
BCC9rS07QWb13p5WwAZL3o6F3ttY4+FS38R5zh6T7xtYyjA1BgkqhkiG9w0BCQ8xKDAmMAsGCWCG
SAFlAwQBKjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwDQYJKoZIhvcNAQEBBQAEggEAw6TMIp6/
tcZ0oifso4wFBjo5Lew3BJ7ax9dUklKshnKtL1oT/TrgMvBAoQSvhplxFtkcf3tKSfG2gfP9pUS5
yqbBHOCE3whPVgsT5BuRWinbP/8rslzd0k7BD8kT2F7xPWEa+Fmyv+Kju4yAD8Mvfidkbu0j6+ol
F6IK9h8ceczG1o/x/cqOxDbpgFTwNRbHbnc2nH1Eo2ynfAbXn3oYRUB1qgCHywinjbZ6R6tTfVqO
ePixsPemyH24qpF5O0Afw/RKeT5+L87GapZmD6HaRiuljKjND0dbLMVihWxjvXz4kynOy2R/0ZbR
Rhv5GBmmiIj8qwG4B2mRkhWf8ljyLQ==


--nextPart3439063.sfYGdeWWPf--




